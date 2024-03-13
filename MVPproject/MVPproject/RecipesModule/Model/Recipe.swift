// Recipe.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Детали рецепта
struct RecipeDetails: Codable {
    /// Вес готового блюда
    let weight: Int
    /// Ингридиенты
    let ingredientLines: [String]
    /// Белки
    let proteins: Int
    /// Жиры
    let fats: Int
    /// Углеводы
    let carbohydrates: Int
    /// Калории
    let calories: Int
}

/// Модель рецепта
struct Recipe: Codable {
    /// Имя картинки
    let imageURL: URL?
    /// Название рецепта
    let name: String
    /// Время приготовления
    let cookingTime: Int
    /// Количество калорий
    let calories: Int
    /// Детали рецепта
    let details: RecipeDetails?
    /// uri
    let uri: String?

    init(
        imageURL: URL?,
        name: String,
        cookingTime: Int,
        calories: Int,
        details: RecipeDetails? = nil,
        uri: String
    ) {
        self.imageURL = imageURL
        self.name = name
        self.calories = calories
        self.cookingTime = cookingTime
        self.details = details
        self.uri = uri
    }

    init?(dto: RecipeDTO) {
        name = dto.label
        calories = Int(dto.calories.rounded())
        cookingTime = Int(dto.totalTime.rounded())
        imageURL = URL(string: dto.image)
        details = nil
        uri = dto.uri
    }

    init?(dto: RecipeDetailsDTO) {
        name = dto.label
        calories = Int(dto.totalNutrients.calories.quantity.rounded())
        cookingTime = Int(dto.totalTime.rounded())
        imageURL = URL(string: dto.image)
        details = RecipeDetails(
            weight: Int(dto.totalWeight.rounded()),
            ingredientLines: dto.ingredientLines,
            proteins: Int(dto.totalNutrients.proteins.quantity.rounded()),
            fats: Int(dto.totalNutrients.fats.quantity.rounded()),
            carbohydrates: Int(dto.totalNutrients.carbohydrates.quantity.rounded()),
            calories: Int(dto.totalNutrients.calories.quantity.rounded())
        )
        uri = nil
    }
}
