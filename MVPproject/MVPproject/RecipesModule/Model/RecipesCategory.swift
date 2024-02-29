// RecipesCategory.swift
// Copyright © RoadMap. All rights reserved.

/// Модель категории рецептов
struct RecipesCategory {
    /// Название типа рецепта
    let name: String
    /// Название пикчи типа рецепта
    let imageName: String
    /// Тип ячейки
    let cellType: ReciperCellSize
}

/// Перечисление размеров ячейки
enum ReciperCellSize {
    /// Маленькая
    case smal
    /// Средняя
    case middle
    /// Большая
    case big
}

/// Структура с методом возвращающим массив типов рецепта
struct RecipesCategories {
    static func getRecipesTypes() -> [RecipesCategory] {
        [
            RecipesCategory(name: "Salad", imageName: "salad", cellType: .middle),
            RecipesCategory(name: "Soup", imageName: "soup", cellType: .middle),
            RecipesCategory(name: "Chicken", imageName: "chicken", cellType: .big),
            RecipesCategory(name: "Meat", imageName: "meat", cellType: .smal),
            RecipesCategory(name: "Fish", imageName: "fish", cellType: .smal),
            RecipesCategory(name: "Side dish", imageName: "sideDish", cellType: .smal),
            RecipesCategory(name: "Drinks", imageName: "drinks", cellType: .big),
            RecipesCategory(name: "Pancake", imageName: "pancakes", cellType: .middle),
            RecipesCategory(name: "Desserts", imageName: "desserts", cellType: .middle)
        ]
    }
}
