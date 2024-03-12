// RecipesResponseDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Recipes Response DTO
struct RecipesResponseDTO: Codable {
    /// Рецепты
    let hits: [HitDTO]
}
