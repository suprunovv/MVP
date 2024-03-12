// Endpoint.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол удаленного ресурса
protocol Endpoint {
    /// Создание удаленного ресурса с параметрами
    init(queryItems: [URLQueryItem])
    /// URL удаленного ресурса
    var url: URL? { get }
}

/// Удаленный ресурс рецептов
struct RecipelyEndpoint: Endpoint {
    var url: URL? {
        var urlComponents = makeBaseURLComponents()
        urlComponents.queryItems = authQueryItems + requiredQueryItems + queryItems
        return urlComponents.url
    }

    private let queryItems: [URLQueryItem]
    private let authQueryItems: [URLQueryItem] = [
        URLQueryItem(name: "app_id", value: "cea69cbe"),
        URLQueryItem(name: "app_key", value: "f0dbdf0e1de381a3491ca0757b29bdf6")
    ]
    private let requiredQueryItems: [URLQueryItem] = [
        URLQueryItem(name: "type", value: "public")
    ]

    init(queryItems: [URLQueryItem] = []) {
        self.queryItems = queryItems
    }

    private func makeBaseURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.edamam.com"
        components.path = "/api/recipes/v2"
        return components
    }
}
