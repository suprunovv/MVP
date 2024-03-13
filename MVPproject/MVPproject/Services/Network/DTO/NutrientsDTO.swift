// NutrientsDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Структура КБЖУ
struct NutrientsDTO: Codable {
    /// белки
    let proteins: QuantityDTO
    /// жиры
    let fats: QuantityDTO
    /// углеводы
    let carbohydrates: QuantityDTO
    /// калории
    let calories: QuantityDTO

    enum CodingKeys: String, CodingKey {
        case proteins = "PROCNT"
        case fats = "FAT"
        case carbohydrates = "CHOCDF"
        case calories = "ENERC_KCAL"
    }
}
