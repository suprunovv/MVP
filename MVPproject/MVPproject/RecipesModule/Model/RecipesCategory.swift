// RecipesCategory.swift
// Copyright © RoadMap. All rights reserved.

/// Модель категории рецептов
struct RecipesCategory {
    /// Название типа рецепта
    let name: String
    /// Название пикчи типа рецепта
    let imageName: String
    /// Тип ячейки
    let cellSize: ReciperCellSize
}

/// Перечисление размеров ячейки
enum ReciperCellSize {
    /// Маленькая
    case small
    /// Средняя
    case middle
    /// Большая
    case big
}

/// Структура с методом возвращающим массив типов рецепта
struct RecipesCategories {
    static func getRecipesTypes() -> [RecipesCategory] {
        [
            RecipesCategory(name: "Salad", imageName: "salad", cellSize: .middle),
            RecipesCategory(name: "Soup", imageName: "soup", cellSize: .middle),
            RecipesCategory(name: "Chicken", imageName: "chicken", cellSize: .big),
            RecipesCategory(name: "Meat", imageName: "meat", cellSize: .small),
            RecipesCategory(name: "Fish", imageName: "fish", cellSize: .small),
            RecipesCategory(name: "Side dish", imageName: "sideDish", cellSize: .small),
            RecipesCategory(name: "Drinks", imageName: "drinks", cellSize: .big),
            RecipesCategory(name: "Pancake", imageName: "pancakes", cellSize: .middle),
            RecipesCategory(name: "Desserts", imageName: "desserts", cellSize: .middle)
        ]
    }
}
