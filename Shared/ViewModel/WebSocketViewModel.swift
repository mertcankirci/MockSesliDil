//
//  WebSocketViewModel.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 10.07.2025.
//

import Foundation

final class WebSocketViewModel: ObservableObject {
    private var webSocketService: WebSocketServiceProtocol
    
    private(set) var receivedChunks: [Chunk] = []
    
    var onChunksUpdated: (([Chunk]) -> Void)?
    var onConnectionClosed: (() -> Void)?
    
    init(webSocketService: WebSocketServiceProtocol) {
        self.webSocketService = webSocketService
        setupBindings()
    }
    
    func connect() {
        webSocketService.connect()
        sendHelloCommand()
    }
    
    func disconnect() {
        webSocketService.disconnect()
    }
    
    private func sendHelloCommand() {
        webSocketService.send("merhaba")
    }
    
    func setupBindings() {
        webSocketService.onMessageReceived = { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.handleRecievedData(data)
                case .failure(let error):
                    print("Error websocket viewmodel \(error)")
                }
            }
        }
    }
    
    func handleRecievedData(_ data: Data) {
        if let doneMessage = String(data: data, encoding: .utf8), doneMessage == "--DONE--" {
            disconnect()
            onConnectionClosed?()
            return 
        }

        do {
            let chunk = try JSONDecoder().decode(Chunk.self, from: data)
            if !receivedChunks.contains(where: { $0.chunk_index == chunk.chunk_index }) {
                receivedChunks.append(chunk)
                onChunksUpdated?(receivedChunks)
            }
        } catch(let error) {
            print("error in decoding data: \(error)")
        }
    }

}
