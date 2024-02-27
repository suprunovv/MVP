// Builder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол билдера модуля
protocol Builder {
    /// Сборка модуля
    static func makeModule() -> UIViewController
}
