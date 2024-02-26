// UIFont+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для шрифта Verdana
extension UIFont {
    /// Шрифт вердана с жирностью 400
    /// - Parameter ofSize: размер шрифта
    /// - Returns: опциональный шрифт вердана
    static func verdana(ofSize size: CGFloat) -> UIFont? {
        UIFont(name: "Verdana", size: size)
    }

    /// Шрифт вердана с жирностью 700
    /// - Parameter ofSize: размер шрифта
    /// - Returns: опциональный жирный шрифт вердана
    static func verdanaBold(ofSize size: CGFloat) -> UIFont? {
        UIFont(name: "Verdana-Bold", size: size)
    }
}
