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
    /// Запрос деталей рецепта
    func getRecipesDetailsByURI(_ uri: String, completion: @escaping (Result<DetailsDTO?, Error>) -> Void)
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

    func getRecipesDetailsByURI(_ uri: String, completion: @escaping (Result<DetailsDTO?, Error>) -> Void) {
        let uriItem = URLQueryItem(name: QueryParameters.uri, value: uri)
        let endpoint = RecipelyEndpoint(path: QueryParameters.deatailsURIPath, queryItems: [uriItem])
        makeRequest(endpoint) { result in
            switch result {
                case .failure(let error):
                    return completion(.failure(error))
                case .success(let data):
                    do {
                        let detailsDto = try JSONDecoder().decode(DetailDTO.self, from: data)
                        return completion(.success(detailsDto.hits.first?.recipe))
                    } catch {
                        return completion(.failure(error))
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
}
