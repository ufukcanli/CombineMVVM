//
//  NetworkManager.swift
//  CombineMVVM
//
//  Created by Ufuk Canlı on 29.03.2022.
//

import Foundation

enum NetworkManager {
    static func getComments(by id: Int, completion: @escaping (Result<[Comment], Error>) -> Void) {
        let endpoint = "https://jsonplaceholder.typicode.com/posts/\(id)/comments"
        URLSession.shared.dataTask(with: URL(string: endpoint)!) { data, response, error in
            do {
                let decoder = JSONDecoder()
                let comments = try decoder.decode([Comment].self, from: data!)
                completion(.success(comments))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
