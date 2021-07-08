//
//  String.swift
//  ChuckNorrisFacts
//
//  Created by George de Araújo Apostolakis on 06/07/21.
//
import UIKit

extension String {
        func proper() -> String {
            return prefix(1).capitalized + dropFirst()
        }
}
