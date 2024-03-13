// DetailDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Главная структура запроса
struct DetailDTO: Codable {
    let hits: [Hits]
}

/// Промежуточная структура
struct Hits: Codable {
    let recipe: DetailsDTO
}

/// Структура с детальным описанием рецепта
struct DetailsDTO: Codable {
    let label: String
    let image: String
    let totalWeight: Double
    let totalTime: Double
    let ingredientLines: [String]
    let totalNutrients: NutrientsDTO
}

/// Структура КБЖУ
struct NutrientsDTO: Codable {
    let proteins: Quantity
    let fats: Quantity
    let carbohydrates: Quantity
    let calories: Quantity

    enum CodingKeys: String, CodingKey {
        case proteins = "PROCNT"
        case fats = "FAT"
        case carbohydrates = "CHOCDF"
        case calories = "ENERC_KCAL"
    }
}

/// Структура для значений КБЖУ
struct Quantity: Codable {
    let quantity: Double
}
