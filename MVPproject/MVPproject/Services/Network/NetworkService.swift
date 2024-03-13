// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол сервиса сети
protocol NetworkServiceProtocol {
    /// Запрос рецептов по категории
    func getRecipesByCategory(
        _ categoryRequestDTO: CategoryRequestDTO,
        completion: @escaping (Result<[HitDTO], Error>) -> ()
    )
}

/// Сервис запроса данных из сети
final class NetworkService: NetworkServiceProtocol {
    private enum QueryParameters {
        static let dishType = "dishType"
        static let health = "health"
        static let query = "q"
    }

    private let session = URLSession.shared
    private let decoder = JSONDecoder()

    func getRecipesByCategory(
        _ categoryRequestDTO: CategoryRequestDTO,
        completion: @escaping (Result<[HitDTO], Error>) -> ()
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
                    return completion(.failure(error))
                case let .success(data):
                    do {
                        let recipesDto = try self.decoder.decode(RecipesResponseDTO.self, from: data)
                        completion(.success(recipesDto.hits))
                    } catch {
                        completion(.failure(NetworkError.parsing))
                    }
                }
            }
        }
    }

    private func makeRequest(_ endpoint: Endpoint, then handler: @escaping (Result<Data, Error>) -> Void) {
        guard let url = endpoint.url else {
            return handler(.failure(NetworkError.invalidURL))
        }

        let task = session.dataTask(with: url) { data, _, error in
            if let error = error {
                return handler(.failure(NetworkError.network(error)))
            }
            guard let data = data else {
                return handler(.failure(NetworkError.emptyData))
            }
            handler(.success(data))
        }

        task.resume()
    }

    func getDish(byURI uri: String, completion: @escaping (Result<DetailRecipe, Error>) -> Void) {
        let uriItem = URLQueryItem(name: "uri", value: uri)
        let baseUrlComponents = RecipelyEndpoint(queryItems: [uriItem])
        guard var url = baseUrlComponents.url else { return }
        url.appendPathComponent("by-uri")
        makeURLRequest(using: url) { (networkResult: Result<DetailDTO, Error>) in
            switch networkResult {
            case let .success(result):
                guard let dishDto = result.hits.first?.recipe else { return }
                completion(.success(DetailRecipe(dto: dishDto)))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    private func makeURLRequest(
        using request: URL,
        completion: @escaping (Result<DetailDTO, Error>) -> Void
    ) {
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(DetailDTO.self, from: data)
                completion(.success(result))
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
