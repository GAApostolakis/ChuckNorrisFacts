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
        let facts = Facts(total: 0, result: [])
        let viewModel = HomeViewModelImp1(coordinator: self, repository: repository, facts: facts)
        let homeVC = HomeViewController(viewModel: viewModel)
        currentVC = homeVC
        window.rootViewController = homeVC
        window.makeKeyAndVisible()
    }
    
    func presentSearch (facts: Facts, completion: @escaping () -> Void) {
        let viewModel = SearchViewModelImp1(repository: repository, coordinator: self, facts: facts)
        let searchVC = SearchViewController(viewModel: viewModel)
        searchVC.modalPresentationStyle = .popover
        currentVC?.present(searchVC, animated: true, completion: {
            self.currentVC = searchVC
            completion()
        })
    }
    
    func dismissToHome(facts: Facts) {
        let parentVC = currentVC?.presentingViewController as? HomeViewController
        parentVC?.viewModel.facts = facts
        currentVC?.dismiss(animated: true, completion: {
            parentVC?.viewModel.reloadTableView()
            self.currentVC = parentVC
        })
    }
}
