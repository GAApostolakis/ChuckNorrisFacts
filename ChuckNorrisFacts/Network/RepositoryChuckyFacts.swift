//
//  RepositoryChuckyFacts.swift
//  ChuckNorrisFacts
//
//  Created by George de Araújo Apostolakis on 04/07/21.
//
import Foundation
import Moya

struct RepositoryChuckyFacts: Repository {
    
    let provider = MoyaProvider<FactsTarget>()
    
    func fetchRandom(sucessHandler: @escaping (Fact) -> Void, errorHandler: @escaping (String) -> Void) {
        provider.request(.random) { result in
            switch result {
            case .success (let response):
                do {
                    let fact = try response.map(Fact.self)
                    sucessHandler(fact)
                }
                catch {
                    errorHandler(error.localizedDescription.description)
                }
            case .failure(let error):
                errorHandler(error.localizedDescription.description)
            }
        }
    }
    
    func fetchCategory(category: String, sucessHandler: @escaping (Fact) -> Void, errorHandler: @escaping (String) -> Void) {
        provider.request(.category(chosenCategory: category)) { result in
            switch result {
            case .success(let response):
                do {
                    let fact = try response.map(Fact.self)
                    sucessHandler(fact)
                }
                catch {
                    errorHandler(error.localizedDescription.description)
                }
            case .failure(let error):
                errorHandler(error.localizedDescription.description)
            }
        }
    }
    
    func fetchSearch(query: String, sucessHandler: @escaping (Facts) -> Void, errorHandler: @escaping (String) -> Void) {
        provider.request(.search(query: query)) { result in
            switch result {
            case .success(let response):
                do {
                    let facts = try response.map(Facts.self)
                    sucessHandler(facts)
                }
                catch {
                    errorHandler(error.localizedDescription.description)
                }
            case .failure(let error):
                errorHandler(error.localizedDescription.description)
            }
        }
    }
}
