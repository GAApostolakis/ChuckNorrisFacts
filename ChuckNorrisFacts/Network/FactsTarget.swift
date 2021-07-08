//
//  File.swift
//  ChuckNorrisFacts
//
//  Created by George de Araújo Apostolakis on 03/07/21.
//

import Moya

enum FactsTarget {
    case random
    case category (chosenCategory: String)
    case search (query: String)
}

extension FactsTarget: TargetType{
    var baseURL: URL {
        return URL(string: "https://api.chucknorris.io/jokes")!
    }
    
    var path: String {
        switch self{
        case .random:
            return "/random"
        case .category:
            return "/random"
        case .search:
            return "/search"
        }
    }
    
    var method: Method {
        switch self {
        case .random:
            return .get
        case .category:
            return .get
        case .search:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self{
        case .random:
        return .requestPlain
        case let .category(chosenCategory):
            return .requestParameters(
                parameters: ["category": chosenCategory],
                encoding: URLEncoding.queryString
                )
        case let .search(query):
            return .requestParameters(
                parameters: ["query": query],
                encoding: URLEncoding.queryString
                )
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

