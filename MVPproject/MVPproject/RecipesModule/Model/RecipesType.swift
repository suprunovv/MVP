// RecipesType.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель типа рецепта
struct RecipesType {
    /// Название типа рецепта
    let name: String
    /// Название пикчи типа рецепта
    let imageName: String
}

/// Структура с методом возвращающим массив типов рецепта
struct RecipesTypes {
    static func getRecipesTypes() -> [RecipesType] {
        [
            RecipesType(name: "Salad", imageName: "salad"),
            RecipesType(name: "Soup", imageName: "soup"),
            RecipesType(name: "Chicken", imageName: "chicken"),
            RecipesType(name: "Meat", imageName: "meat"),
            RecipesType(name: "Fish", imageName: "fish"),
            RecipesType(name: "Side dish", imageName: "sideDish"),
            RecipesType(name: "Drinks", imageName: "drinks"),
            RecipesType(name: "Pancake", imageName: "pancakes"),
            RecipesType(name: "Desserts", imageName: "desserts")
        ]
    }
}
