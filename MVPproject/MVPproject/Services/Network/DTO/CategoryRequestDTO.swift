// CategoryRequestDTO.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// DTO для запроса рецептов в категории
struct CategoryRequestDTO {
    /// Значение квери параметра для типа блюда
    let dishTypeValue: String
    /// Значение квери параметра для уточняющего запроса
    let queryValue: String?
    /// Значение квери параметра для здоровых опций
    let healthValue: String?

    init(category: RecipesCategory) {
        dishTypeValue = CategoryRequestDTO.getDishTypeValue(for: category.type)
        queryValue = CategoryRequestDTO.getQueryValue(for: category.type)
        healthValue = CategoryRequestDTO.getHealthValue(for: category.type)
    }

    private static func getDishTypeValue(for type: RecipesCategory.CategoryType) -> String {
        switch type {
        case .chicken, .meat, .fish, .sideDish:
            return "main course"
        case .salad:
            return "salad"
        case .soup:
            return "soup"
        case .pancake:
            return "panake"
        case .drinks:
            return "drinks"
        case .dessert:
            return "desserts"
        }
    }

    private static func getQueryValue(for type: RecipesCategory.CategoryType) -> String? {
        switch type {
        case .chicken:
            return "chicken"
        case .fish:
            return "fish"
        case .meat:
            return "meat"
        default:
            return nil
        }
    }

    private static func getHealthValue(for type: RecipesCategory.CategoryType) -> String? {
        switch type {
        case .sideDish:
            return String(["vegetarian"].joined(separator: ","))
        default:
            return nil
        }
    }
}
