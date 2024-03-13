// ViewState.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Стейт вью
enum ViewState<T> {
    case loading
    case data(T)
    case noData
    case error(Error)
}
