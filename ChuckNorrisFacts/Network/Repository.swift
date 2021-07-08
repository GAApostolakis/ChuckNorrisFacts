//
//  Repository.swift
//  ChuckNorrisFacts
//
//  Created by George de Araújo Apostolakis on 04/07/21.
//
import Foundation

protocol Repository {
    func fetchRandom (sucessHandler: @escaping (Fact) -> Void, errorHandler: @escaping (String) -> Void)
    func fetchCategory (category: String, sucessHandler: @escaping (Fact) -> Void, errorHandler: @escaping (String) -> Void)
    func fetchSearch (query: String, sucessHandler: @escaping (Facts) -> Void, errorHandler: @escaping (String) -> Void)
}
