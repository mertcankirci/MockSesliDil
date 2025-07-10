//
//  ChatViewModel.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 10.07.2025.
//

import Foundation
import SwiftUI

final class ChatViewModel: ObservableObject {
    private let webSocketViewModel: WebSocketViewModel
    
    @Published var displayedChunkText: String = ""
    @Published var didConnectionClosed: Bool = false
    
    var displayedChunks: [Chunk] = []
    
    init(webSocketViewModel: WebSocketViewModel) {
        self.webSocketViewModel = webSocketViewModel
        bindWebSocketChunks()
    }
    
    func connect() {
        webSocketViewModel.connect()
    }
    
    func disconnect() {
        webSocketViewModel.disconnect()
    }
    
    private func bindWebSocketChunks() {
        webSocketViewModel.onChunksUpdated = { [weak self] chunks in
            DispatchQueue.main.async {
                self?.displayedChunks = chunks
                if let chunkText = self?.mergeChunksToText(chunks) {
                    self?.displayedChunkText = chunkText
                }
            }
        }
        
        webSocketViewModel.onConnectionClosed = { [weak self] in
            DispatchQueue.main.async {
                withAnimation {
                    self?.didConnectionClosed = true 
                }
            }
        }
    }
    
    private func mergeChunksToText(_ chunks: [Chunk]) -> String {
        let sortedChunks = chunks.sorted(by: { $0.chunk_index < $1.chunk_index })
        let combinedText = sortedChunks.map { $0.data }.joined()
        return combinedText
    }
}
