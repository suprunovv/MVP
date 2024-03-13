// DetailDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Детали рецепта
struct DetailDTO: Codable {
    /// хиты
    let hits: [DetailHitsDTO]
}
