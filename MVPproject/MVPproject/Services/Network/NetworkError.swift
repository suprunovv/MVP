// NetworkError.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ошибки сети
enum NetworkError: Error {
    /// Невалидный URL
    case invalidURL
    /// Ошибки выполнения запроса
    case network(Error)
    /// Пустая дата
    case emptyData
    /// Ошибки парсинга
    case parsing
}
