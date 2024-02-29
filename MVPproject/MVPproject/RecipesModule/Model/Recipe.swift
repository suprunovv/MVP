// Recipe.swift
// Copyright © RoadMap. All rights reserved.

/// Модель рецепта
struct Recipe {
    /// Имя картинки
    let imageName: String
    /// Название рецепта
    let name: String
    /// Время приготовления
    let cookingTime: Int
    /// Количество калорий
    let calories: Int
    /// Категория рецепта
    let categoryType: RecipesCategory.CategoryType
}
