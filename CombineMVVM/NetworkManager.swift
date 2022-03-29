//
//  NetworkManager.swift
//  CombineMVVM
//
//  Created by Ufuk Canlı on 29.03.2022.
//

import Foundation

enum NetworkManager {
    static func getAnimals(completion: @escaping (Result<[Animal], Error>) -> Void) {
        let animals: [Animal] = [.dog, .cat, .frog, .panda, .lion]
        completion(.success(animals))
    }
}
