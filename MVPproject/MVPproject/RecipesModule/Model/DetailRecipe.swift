// DetailRecipe.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class DetailRecipe {
    let label: String
    let image: URL?
    let totalWeight: Double
    let totalTime: Double
    let ingredientLines: [String]
    let proteins: Int
    let fats: Int
    let carbohydrates: Int
    let calories: Int

    init(dto: DetailsDTO) {
        label = dto.label
        image = URL(string: dto.image)
        totalWeight = dto.totalWeight
        totalTime = dto.totalTime
        ingredientLines = dto.ingredientLines
        proteins = Int(dto.totalNutrients.proteins.quantity)
        fats = Int(dto.totalNutrients.fats.quantity)
        carbohydrates = Int(dto.totalNutrients.carbohydrates.quantity)
        calories = Int(dto.totalNutrients.calories.quantity)
    }
}
