//
//  HomeViewModel.swift
//  ChuckNorrisFacts
//
//  Created by George de Araújo Apostolakis on 05/07/21.
//
protocol SearchViewModel {
    var didStartActivity: (() -> Void)? { get set }
    var didEndActivity: (() -> Void)? { get set }
    var didFailToFetch: ((String) -> Void)? { get set }
    var changeCategory: ((String) -> Void)? { get set }
    
    func fetchRandomFact()
    func newCategory(parameter: Int)
    func fetchCategory()
    func fetchSearch(query: String)
}

final class SearchViewModelImp1: SearchViewModel {
    //MARK: - Events
    
    var didStartActivity: (() -> Void)?
    var didEndActivity: (() -> Void)?
    var didFailToFetch: ((String) -> Void)?
    var changeCategory: ((String) -> Void)?
    //MARK: - Variables & Init
    
    let categoriesList = CategoriesList()
    var index: Int = 0
    
    var repository: Repository
    let coordinator: Coordinator
    var facts: Facts
    init (repository: Repository, coordinator: Coordinator, facts: Facts) {
        self.repository = repository
        self.coordinator = coordinator
        self.facts = facts
    }
    //MARK: - Methods
    
    func fetchRandomFact() {
        didStartActivity?()
        repository.fetchRandom(sucessHandler: {[weak self] fact in
            self?.didEndActivity?()
            self?.facts.result.append(fact)
            self?.facts.total += 1
            let safeFacts = Facts(total: 1, result: [fact])
            self?.facts.result.insert(contentsOf: safeFacts.result, at: 0)
            if let safeFacts = self?.facts {
                self?.coordinator.dismissToHome(facts: safeFacts)
            }
        }, errorHandler: {[weak self] error in
            self?.didEndActivity?()
            self?.didFailToFetch?(error)
        })
    }
    
    func newCategory(parameter: Int){
        didStartActivity?()
        index = index + parameter
        if index < 0 {
            index = 15
        }
        else if index > 15 {
            index = 0
        }
        let category = categoriesList.categories[index]
        changeCategory?(category)
        didEndActivity?()
    }
    
    func fetchCategory() {
        didStartActivity?()
        repository.fetchCategory(category: categoriesList.categories[index], sucessHandler: {[weak self] fact in
            self?.didEndActivity?()
            let safeFacts = Facts(total: 1, result: [fact])
            self?.facts.result.insert(contentsOf: safeFacts.result, at: 0)
            self?.facts.total += 1
            if let safeFacts = self?.facts {
                self?.coordinator.dismissToHome(facts: safeFacts)
            }
        }, errorHandler: {[weak self] error in
            self?.didEndActivity?()
            self?.didFailToFetch?(error)
        })
    }
    
    func fetchSearch(query: String) {
        didStartActivity?()
        repository.fetchSearch(query: query, sucessHandler: {[weak self] facts in
            self?.didEndActivity?()
            if facts.total > 0 {
                self?.facts.total += facts.total
                self?.facts.result.insert(contentsOf: facts.result, at: 0)
                if let safeFacts = self?.facts {
                    self?.coordinator.dismissToHome(facts: safeFacts)
                }
            }else {
                self?.didFailToFetch?("No Results to the Query")
            }
        }, errorHandler: {[weak self] error in
            self?.didEndActivity?()
            self?.didFailToFetch?(error)
        })
    }
    
}
