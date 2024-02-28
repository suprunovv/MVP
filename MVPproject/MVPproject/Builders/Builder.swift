// Builder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол сборщика модуля
protocol Builder {
    /// Собрать модуль
    static func makeModule() -> UIViewController
}
