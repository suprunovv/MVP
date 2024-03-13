// RecipeDetailsDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Детальное описание рецепта
struct RecipeDetailsDTO: Codable {
    /// название редепта
    let label: String
    /// картинка
    let image: String
    /// вес блюда
    let totalWeight: Double
    /// время приготовления
    let totalTime: Double
    /// ингридиенты
    let ingredientLines: [String]
    /// структура КБЖУ
    let totalNutrients: NutrientsDTO
}
