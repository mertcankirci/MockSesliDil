//
//  WebSocketService.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 10.07.2025.
//

import Foundation

protocol WebSocketServiceProtocol {
    func connect()
    func disconnect()
    func send(_ message: String)
    var onMessageReceived: ((Result<Data, Error>) -> Void)? { get set }
}

final class WebSocketService: WebSocketServiceProtocol {
    private var webSocketTask: URLSessionWebSocketTask?
    private let url: URL
    private let session: URLSession
    
    var onMessageReceived: ((Result<Data, any Error>) -> Void)?
    
    private var isConnected: Bool = false
    
    init(url: URL, session: URLSession = .shared) {
        self.url = url
        self.session = session
    }
    
    
    func connect() {
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.resume()
        isConnected = true
        listen()
    }
    
    func disconnect() {
        isConnected = false
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }
    
    func send(_ message: String) {
        let textMessage = URLSessionWebSocketTask.Message.string(message)
        webSocketTask?.send(textMessage) { error in
            if let error = error {
                print("Send error: \(error)")
            }
        }
    }
    
    private func listen() {
        guard isConnected else { return }

        webSocketTask?.receive { [weak self] result in
            guard let self else { return }

            switch result {
            case .failure(let error):
                self.onMessageReceived?(.failure(error))
            case .success(let message):
                switch message {
                case .data(let data):
                    self.onMessageReceived?(.success(data))
                case .string(let text):
                    if let data = text.data(using: .utf8) {
                        self.onMessageReceived?(.success(data))
                    }
                @unknown default:
                    break
                }
            }

            if self.isConnected {
                self.listen()
            }
        }
    }
}
