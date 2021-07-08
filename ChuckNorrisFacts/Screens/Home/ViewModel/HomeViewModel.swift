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
    var didAddNewData: (() -> Void)? { get set }
    
    var facts: Facts { get set }
    
    func presentSearch ()
    func reloadTableView ()
    func clearFacts ()
}

class HomeViewModelImp1: HomeViewModel {
    //MARK: - Variables & Init & Events
    
    var coordinator: Coordinator
    var repository: Repository
    var facts: Facts
    
    init(coordinator: Coordinator, repository: Repository, facts: Facts) {
        self.coordinator = coordinator
        self.repository = repository
        self.facts = facts
    }
    
    var didStartActivity: (() -> Void)?
    var didEndActivity: (() -> Void)?
    var didAddNewData: (() -> Void)?
    
    //MARK: - Methods
    
    func presentSearch() {
        didStartActivity?()
        coordinator.presentSearch(facts: facts, completion: {
            self.didEndActivity?()
        })
    }
    
    func reloadTableView() {
        didAddNewData?()
    }
    
    func clearFacts() {
        facts = Facts(total: 0, result: [])
        didAddNewData?()
    }
    
}
