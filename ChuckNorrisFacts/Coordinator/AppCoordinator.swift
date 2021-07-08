//
//  AppCoordinator.swift
//  ChuckNorrisFacts
//
//  Created by George de Araújo Apostolakis on 05/07/21.
//
import UIKit

class AppCoordinator: Coordinator {
    var window: UIWindow
    var currentVC: UIViewController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let repository = RepositoryChuckyFacts()
        let viewModel = SearchViewModelImp1 (repository: repository, coordinator: self)
        let home = SearchViewController (viewModel: viewModel)
        currentVC = home
        window.rootViewController = home
        window.makeKeyAndVisible()
    }
}
