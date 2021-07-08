//
//  UIViewController.swift
//  ChuckNorrisFacts
//
//  Created by George de Araújo Apostolakis on 08/07/21.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTapHappens() {
        let tap = UITapGestureRecognizer (target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
