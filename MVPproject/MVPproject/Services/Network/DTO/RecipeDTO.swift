// RecipeDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Recipe DTO
struct RecipeDTO: Codable {
    /// Имя
    var label: String
    /// Картинка
    var image: String
    /// Количество калорий
    var calories: Double
    /// Время готовки
    var totalTime: Double
}
