//
//  UIButton.swift
//  ChuckNorrisFacts
//
//  Created by George de Araújo Apostolakis on 06/07/21.
//
import UIKit

extension UIButton {
    func roundButton() {
        self.layer.cornerRadius = 20.0
        self.layer.borderWidth  = 3.0
        self.layer.borderColor = UIColor.black.cgColor
    }
}
