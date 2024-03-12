// Recipe.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Детали рецепта
struct RecipeDetails: Codable {
    /// Категория рецепта
    let categoryType: RecipesCategory.CategoryType
    /// Вес готового блюда
    let weight: Int
    /// Полное описание приготовления
    let description: String
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

    init(
        imageURL: URL?,
        name: String,
        cookingTime: Int,
        calories: Int,
        details: RecipeDetails? = nil
    ) {
        self.imageURL = imageURL
        self.name = name
        self.calories = calories
        self.cookingTime = cookingTime
        self.details = details
    }

    init?(dto: RecipeDTO) {
        name = dto.label
        calories = Int(dto.calories.rounded())
        cookingTime = Int(dto.totalTime.rounded())
        imageURL = URL(string: dto.image)
        details = nil
    }

    // TODO: implement when DTO is ready
//    init?(dto: RecipeDetailsDTO) {
//        self.name = dto.label
//        self.calories = Int(dto.calories.rounded())
//        self.cookingTime = Int(dto.totalTime.rounded())
//        self.imageURL = URL(string: dto.image)
//        self.details = RecipeDetails()
//    }
}
