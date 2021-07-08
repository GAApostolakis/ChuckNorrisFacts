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
    var repository: Repository
    
    init (repository: Repository, window: UIWindow) {
        self.repository = repository
        self.window = window
    }
    
    func start() {
        let repository = RepositoryChuckyFacts()
        let viewModel = HomeViewModelImp1(coordinator: self, repository: repository)
        let homeVC = HomeViewController(viewModel: viewModel)
        currentVC = homeVC
        window.rootViewController = homeVC
        window.makeKeyAndVisible()
    }
    
    func showSearch (completion: @escaping () -> Void) {
        let viewModel = SearchViewModelImp1(repository: repository, coordinator: self)
        let searchVC = SearchViewController(viewModel: viewModel)
        searchVC.modalPresentationStyle = .popover
        currentVC?.present(searchVC, animated: true, completion: completion)
    }
}
