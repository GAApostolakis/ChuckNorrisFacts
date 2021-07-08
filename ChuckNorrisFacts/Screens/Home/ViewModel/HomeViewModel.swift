//
//  HomeViewModel.swift
//  ChuckNorrisFacts
//
//  Created by George de Araújo Apostolakis on 08/07/21.
//
import Foundation

protocol HomeViewModel {
    var didStartActivity: (() -> Void)? { get set }
    var didEndActivity: (() -> Void)? { get set }
    
    func presentSearch ()
}

class HomeViewModelImp1: HomeViewModel {
    //MARK: - Variables & Init & Events
    
    var coordinator: Coordinator
    var repository: Repository
    
    init(coordinator: Coordinator, repository: Repository) {
        self.coordinator = coordinator
        self.repository = repository
    }
    
    var didStartActivity: (() -> Void)?
    var didEndActivity: (() -> Void)?
    
    //MARK: - Methods
    
    func presentSearch() {
        didStartActivity?()
        coordinator.showSearch(completion: {
            self.didEndActivity?()
        })
    }
}
