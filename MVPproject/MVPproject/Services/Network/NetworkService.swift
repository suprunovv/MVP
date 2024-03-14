// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол сервиса сети
protocol NetworkServiceProtocol {
    /// Запрос рецептов по категории
    func getRecipesByCategory(
        _ categoryRequestDTO: CategoryRequestDTO,
        completion: @escaping (Result<[Recipe], NetworkError>) -> ()
    )
    /// Запрос деталей рецепта
    func getRecipesDetailsByURI(_ uri: String, completion: @escaping (Result<Recipe, NetworkError>) -> Void)
}

/// Сервис запроса данных из сети
final class NetworkService: NetworkServiceProtocol {
    private enum QueryParameters {
        static let dishType = "dishType"
        static let health = "health"
        static let query = "q"
        static let uri = "uri"
        static let deatailsURIPath = "by-uri"
    }

    private let session = URLSession.shared
    private let decoder = JSONDecoder()

    func getRecipesByCategory(
        _ categoryRequestDTO: CategoryRequestDTO,
        completion: @escaping (Result<[Recipe], NetworkError>) -> ()
    ) {
        var queryItems = [URLQueryItem(name: QueryParameters.dishType, value: categoryRequestDTO.dishTypeValue)]
        if let healthValue = categoryRequestDTO.healthValue {
            queryItems.append(URLQueryItem(name: QueryParameters.health, value: healthValue))
        }
        if let queryValue = categoryRequestDTO.queryValue {
            queryItems.append(URLQueryItem(name: QueryParameters.query, value: queryValue))
        }

        let endpoint = RecipelyEndpoint(queryItems: queryItems)
        makeRequest(endpoint) { result in
            DispatchQueue.main.async {
                switch result {
                case let .failure(error):
                    return completion(.failure(.network(error.localizedDescription)))
                case let .success(data):
                    do {
                        let recipesDto = try self.decoder.decode(RecipesResponseDTO.self, from: data)
                        let recipes = recipesDto.hits.compactMap { Recipe(dto: $0.recipe) }
                        if recipes.isEmpty {
                            completion(.failure(.emptyData))
                        } else {
                            completion(.success(recipes))
                        }
                    } catch {
                        completion(.failure(.parsing))
                    }
                }
            }
        }
    }

    func getRecipesDetailsByURI(_ uri: String, completion: @escaping (Result<Recipe, NetworkError>) -> Void) {
        let uriItem = URLQueryItem(name: QueryParameters.uri, value: uri)
        let endpoint = RecipelyEndpoint(path: QueryParameters.deatailsURIPath, queryItems: [uriItem])
        makeRequest(endpoint) { result in
            DispatchQueue.main.async {
                switch result {
                case let .failure(error):
                    return completion(.failure(error))
                case let .success(data):
                    do {
                        let detailsDto = try JSONDecoder().decode(ReecipeDetailsResponseDTO.self, from: data)
                        guard let recipeDetailsDto = detailsDto.hits.first?.recipe,
                              let recipe = Recipe(dto: recipeDetailsDto)
                        else {
                            return completion(.failure(.emptyData))
                        }
                        return completion(.success(recipe))
                    } catch {
                        return completion(.failure(.network(error.localizedDescription)))
                    }
                }
            }
        }
    }

    private func makeRequest(_ endpoint: Endpoint, then handler: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = endpoint.url else {
            return handler(.failure(.invalidURL))
        }

        let task = session.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                return handler(.failure(.network(error.localizedDescription)))
            }
            guard let data = data else {
                return handler(.failure(.emptyData))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                do {
                    let errorMessage = try self?.decoder.decode([ErrorDTO].self, from: data).first?.message
                    return handler(.failure(.network(errorMessage)))
                } catch {
                    return handler(.failure(.network(nil)))
                }
            }

            handler(.success(data))
        }

        task.resume()
    }
}
