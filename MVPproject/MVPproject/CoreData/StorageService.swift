// StorageService.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

/// Сервис для управления данными coreData
final class StorageService {
    // MARK: - Constants
    static let shared = StorageService()
    private init() {}

    // MARK: - Private properties
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    // MARK: - Public methods
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func createRecipesDetailData(recipeDetails: RecipeDetails, uri: String) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "DetailResipeData", in: context)
        else { return }
        let detailRecipe = DetailResipeData(entity: entityDescription, insertInto: context)
        detailRecipe.calories = Int16(recipeDetails.calories)
        detailRecipe.carbohydrates = Int16(recipeDetails.carbohydrates)
        detailRecipe.fats = Int16(recipeDetails.fats)
        detailRecipe.ingredientLines = recipeDetails.ingredientLines
        detailRecipe.proteins = Int16(recipeDetails.proteins)
        detailRecipe.weight = Int16(recipeDetails.weight)
        detailRecipe.uri = uri
        saveContext()
    }

    func createRecipeData(recipes: [Recipe], category: RecipesCategory) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "RecipeData", in: context)
        else { return }
        for recipe in recipes {
            let recipeData = RecipeData(entity: entityDescription, insertInto: context)
            recipeData.name = recipe.name
            recipeData.imageURL = recipe.imageURL?.absoluteString
            recipeData.cookingTime = Int16(recipe.cookingTime)
            recipeData.calories = Int16(recipe.calories)
            recipeData.uri = recipe.uri
            recipeData.details = nil
            recipeData.category = category.type.rawValue
        }
        saveContext()
    }

    func fetchDetailRecipe(uri: String) -> RecipeDetails? {
        do {
            guard let result = try? context.fetch(DetailResipeData.fetchRequest()) else { return nil }
            guard let detailRecipe = result.first(where: { $0.uri == uri }) else { return nil }
            return RecipeDetails(detailRecipeData: detailRecipe)
        }
    }

    func fetchRecipeData(category: String) -> [Recipe] {
        do {
            guard let result = try? context.fetch(RecipeData.fetchRequest()) else { return [] }
            let recipesOfCategory = result.filter { $0.category == category }.map { item in
                Recipe(recipeData: item)
            }
            return recipesOfCategory
        }
    }
}
