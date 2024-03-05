// ShimerView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Заглушка с шимером
final class ShimmerView: UIView {
    private let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.gray.cgColor, UIColor.white.cgColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradientLayer
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShimmerAnimation()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupShimmerAnimation() {
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.0, 0.25]
        animation.toValue = [0.75, 1.0, 1.0]
        animation.duration = 1.0
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: "shimmerAnimation")
    }
}
