//
//  TextField.swift
//  ChuckNorrisFacts
//
//  Created by George de Araújo Apostolakis on 06/07/21.
//
import UIKit

extension UITextField {
    func colorBorder(_ color: CGColor, radius value: CGFloat) {
        self.layer.borderColor = color
        self.layer.borderWidth = 2
        self.layer.masksToBounds = false
        self.layer.cornerRadius = value
    }
}
