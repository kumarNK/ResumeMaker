//
//  UITextView.swift
//  ResumeMaker
//
//  Created by Narender Kumar on 29/04/2022.
//


import UIKit

extension UITextView {
    func setRoundedRectBorderStyle() {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.cornerCurve = .continuous
        layer.cornerRadius = 5.0
    }
}
