//
//  Chunk.swift
//  MockSesliDil
//
//  Created by Mertcan Kırcı on 10.07.2025.
//

import Foundation

struct Chunk: Codable {
    let chunk_index: Int
    let total_chunks: Int
    let data: String
}
