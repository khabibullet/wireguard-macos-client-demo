//
//  WGHelper.swift
//  com.khabibullet.wg-cli.helper
//
//  Created by Irek Khabibullin on 04.06.2023.
//

import Foundation

class WGHelper: NSObject, NSXPCListenerDelegate, WGHelperProtocol {

    // MARK: - Properties

    let listener: NSXPCListener

    // MARK: - Initialisation

    override init() {
        self.listener = NSXPCListener(machServiceName: WGHelperConstants.domain)
        super.init()
        self.listener.delegate = self
    }

    // MARK: - Functions // MARK: HelperProtocol

    func wireguardShow(completion: @escaping (String?, Error?) -> Void) {
        do {
            try executeScript(path: "/usr/local/bin/wg", args: ["show"], completion: { result in
                switch result {
                case .success(let output):
                    completion(output, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            })
        } catch {
            completion(nil, error)
        }
    }

    func run() {
        // start listening on new connections
        self.listener.resume()
        // prevent the terminal application to exit
        RunLoop.current.run()
    }

    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
        newConnection.exportedInterface = NSXPCInterface(with: WGHelperProtocol.self)
        newConnection.remoteObjectInterface = NSXPCInterface(with: RemoteApplicationProtocol.self)
        newConnection.exportedObject = self

        newConnection.resume()

        return true
    }
    
    func executeScript(
        path: String, args: [String], completion: @escaping (Result<String, Error>) -> Void
    ) throws {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: path)
        process.arguments = args

        let outputPipe = Pipe()
        process.standardOutput = outputPipe
        process.standardError = outputPipe
        try process.run()

        DispatchQueue.global(qos: .userInteractive).async {
            process.waitUntilExit()

            let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()

            guard let output = String(data: outputData, encoding: .utf8) else {
                completion(.failure(WGHelperError.decodeError))
                return
            }
            completion(.success(output))
        }
    }
    
}
