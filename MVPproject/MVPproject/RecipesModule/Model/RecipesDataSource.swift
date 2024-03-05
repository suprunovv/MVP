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
            categoryType: .fish,
            weight: 543,
            description: RecipesDataSource.description
        ),
        Recipe(
            imageName: "fishDish2",
            name: "Baked Fish with Lemon Herb Sauce",
            cookingTime: 90,
            calories: 616,
            categoryType: .fish,
            weight: 618,
            description: RecipesDataSource.description
        ),
        Recipe(
            imageName: "fishDish3",
            name: "Lemon and Chilli Fish Burrito",
            cookingTime: 90,
            calories: 226,
            categoryType: .fish,
            weight: 310,
            description: RecipesDataSource.description
        ),
        Recipe(
            imageName: "fishDish4",
            name: "Fast Roast Fish & Show Peas Recipes",
            cookingTime: 80,
            calories: 94,
            categoryType: .fish,
            weight: 891,
            description: RecipesDataSource.description
        ),
        Recipe(
            imageName: "fishDish5",
            name: "Salmon with Cantaloupe and Fried Shallots",
            cookingTime: 100,
            calories: 410,
            categoryType: .fish,
            weight: 1432,
            description: RecipesDataSource.description
        ),
        Recipe(
            imageName: "fishDish6",
            name: "Chilli and Tomato Fish",
            cookingTime: 100,
            calories: 174,
            categoryType: .fish,
            weight: 431,
            description: RecipesDataSource.description
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

    static let description = """
    1/2 to 2 fish heads, depending on size, about 5 pounds total
    2 tablespoons vegetable oil
    1/4 cup red or green thai curry paste
    3 tablespoons fish sauce or anchovy sauce
    1 tablespoon sugar
    1 can coconut milk, about 12 ounces
    3 medium size asian eggplants, cut int 1 inch rounds
    Handful of bird's eye chilies
    1/2 cup thai basil leaves
    Juice of 3 limes
    1/2 to 2 fish heads, depending on size, about 5 pounds total
    2 tablespoons vegetable oil
    1/4 cup red or green thai curry paste
    3 tablespoons fish sauce or anchovy sauce
    1 tablespoon sugar
    1 can coconut milk, about 12 ounces
    3 medium size asian eggplants, cut int 1 inch rounds
    Handful of bird's eye chilies
    1/2 cup thai basil leaves
    Juice of 3 limes
    1/2 to 2 fish heads, depending on size, about 5 pounds total
    2 tablespoons vegetable oil
    1/4 cup red or green thai curry paste
    3 tablespoons fish sauce or anchovy sauce
    1 tablespoon sugar
    1 can coconut milk, about 12 ounces
    3 medium size asian eggplants, cut int 1 inch rounds
    Handful of bird's eye chilies
    1/2 cup thai basil leaves
    Juice of 3 limes

    """
}
