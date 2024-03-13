// DetailHitsDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Блюдо-хит с деталями
struct DetailHitsDTO: Codable {
    /// рецепт
    let recipe: RecipeDetailsDTO
}
