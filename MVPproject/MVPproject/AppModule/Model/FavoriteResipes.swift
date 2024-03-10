// FavoriteResipes.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель с массивом любимых рецептов
final class FavoriteRecipes {
    private enum Constants {
        static let recipeKay = "recipeKay"
    }

    static var shared = FavoriteRecipes()

    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    private(set) var recipes: [Recipe] = []

    private init() {}

    func updateFavoriteRecipe(_ recipe: Recipe) {
        if recipes.isEmpty {
            recipes.append(recipe)
        } else {
            for (index, value) in recipes.enumerated() where recipe.name == value.name {
                self.recipes.remove(at: index)
                return
            }
            recipes.append(recipe)
        }
    }

    func encodeRecipes() {
        if let encodeResipes = try? encoder.encode(recipes) {
            UserDefaults.standard.set(encodeResipes, forKey: Constants.recipeKay)
        }
    }

    func getRecipes() {
        if let savedResipesData = UserDefaults.standard.object(forKey: Constants.recipeKay) as? Data {
            if let savedRecipes = try? decoder.decode([Recipe].self, from: savedResipesData) {
                recipes = savedRecipes
            }
        }
    }
}
