//
//  HomeViewModel.swift
//  ChuckNorrisFacts
//
//  Created by George de Araújo Apostolakis on 05/07/21.
//
protocol SearchViewModel {
    var didStartActivity: (() -> Void)? { get set }
    var didEndActivity: (() -> Void)? { get set }
    var displayError: ((String) -> Void)? { get set }
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
    var displayError: ((String) -> Void)?
    var changeCategory: ((String) -> Void)?
    //MARK: - Variables & Init
    
    var fact: Fact?
    var facts: Facts?
    let categoriesList = CategoriesList()
    var index: Int = 0
    
    var repository: Repository
    let coordinator: Coordinator
    
    init (repository: Repository, coordinator: Coordinator) {
        self.repository = repository
        self.coordinator = coordinator
    }
    //MARK: - Methods
    
    func fetchRandomFact() {
        didStartActivity?()
        repository.fetchRandom(sucessHandler: {[weak self] fact in
            self?.didEndActivity?()
            self?.fact = fact
            print(fact.value)
            if !(fact.categories!.isEmpty) {
                print(fact.categories?[0])
            }
        }, errorHandler: {[weak self] error in
            self?.didEndActivity?()
            self?.displayError?(error)
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
            self?.fact = fact
            print(fact.value)
            print(fact.categories?[0])
            print("Category\(fact.categories?.count), \n Value: \(fact.value!)")
        }, errorHandler: {[weak self] error in
            self?.didEndActivity?()
            self?.displayError?(error)
        })
    }
    
    func fetchSearch(query: String) {
        didStartActivity?()
        repository.fetchSearch(query: query, sucessHandler: {[weak self] facts in
            self?.didEndActivity?()
            self?.facts = facts
            if !(facts.result[0].categories![0].isEmpty) {
                print("Total:\(facts.total!), Result 0: Category: \(facts.result[0].categories![0]), Value:\(facts.result[0].value!)")
                if !(facts.result[facts.result.count].categories![0].isEmpty) {
                    print("Total:\(facts.total!), Result 0: Category: \(facts.result[0].categories![0]), Value:\(facts.result[0].value!)")
                }
            }
        }, errorHandler: {[weak self] error in
            self?.didEndActivity?()
            self?.displayError?(error)
        })
    }
    
}
