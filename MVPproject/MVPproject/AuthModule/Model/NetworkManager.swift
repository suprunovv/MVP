// NetworkManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Dto1
struct RecipeResponceDto: Codable {
    var hits: [HitDto]
}

/// Dto2
struct HitDto: Codable {
    var recipe: RecipeDTO
}

/// recipeDto
struct RecipeDTO: Codable {
    var label: String
    var image: String
    var calories: Double
    var totalWeight: Double
    var totalTime: Double
}

protocol NetworkManagerProtocol {
    func obtainCategory(url: String, completion: @escaping ([HitDto]?) -> ())
}

/// dfbdfbdfwvsd
final class NetworkManager: NetworkManagerProtocol {
    private let sessionConfiguration = URLSessionConfiguration.default
    private let session = URLSession.shared
    private let decoder = JSONDecoder()

    func obtainCategory(url: String, completion: @escaping ([HitDto]?) -> ()) {
        guard let url = URL(string: url) else { return }
        session.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else {
                return
            }
            do {
                let parceData = try self?.decoder.decode(RecipeResponceDto.self, from: data)
                guard let hits = parceData?.hits else { return }
                completion(hits)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
