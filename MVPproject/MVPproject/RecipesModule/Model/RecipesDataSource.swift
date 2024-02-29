// RecipesDataSource.swift
// Copyright © RoadMap. All rights reserved.

/// Моковые данные для рецептов
struct RecipesDataSource {
    static let recipes: [Recipe] = [
        Recipe(
            imageName: "fishDish1",
            name: "Simple Fish And Corn",
            cookingTime: 60,
            calories: 274,
            categoryType: .fish
        ),
        Recipe(
            imageName: "fishDish2",
            name: "Baked Fish with Lemon Herb Sauce",
            cookingTime: 90,
            calories: 616,
            categoryType: .fish
        ),
        Recipe(
            imageName: "fishDish3",
            name: "Lemon and Chilli Fish Burrito",
            cookingTime: 90,
            calories: 226,
            categoryType: .fish
        ),
        Recipe(
            imageName: "fishDish4",
            name: "Fast Roast Fish & Show Peas Recipes",
            cookingTime: 80,
            calories: 94,
            categoryType: .fish
        ),
        Recipe(
            imageName: "fishDish5",
            name: "Salmon with Cantaloupe and Fried Shallots",
            cookingTime: 100,
            calories: 410,
            categoryType: .fish
        ),
        Recipe(
            imageName: "fishDish6",
            name: "Chilli and Tomato Fish",
            cookingTime: 100,
            calories: 174,
            categoryType: .fish
        ),
    ]

    static var recipesByCategories: [RecipesCategory.CategoryType: [Recipe]] {
        var recipesByCategories: [RecipesCategory.CategoryType: [Recipe]] = [:]
        for recipe in recipes {
            let categoryType = recipe.categoryType
            recipesByCategories[categoryType] = recipesByCategories[categoryType, default: []] + [recipe]
        }
        return recipesByCategories
    }
}
