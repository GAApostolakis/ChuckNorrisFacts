//
//  Coordinator.swift
//  ChuckNorrisFacts
//
//  Created by George de Araújo Apostolakis on 05/07/21.
//
import UIKit

protocol Coordinator {
    
    var window: UIWindow { get set }
    var currentVC: UIViewController? { get set }
    var repository: Repository { get set }
    
    func start ()
    func showSearch (completion: @escaping () -> Void)
}
