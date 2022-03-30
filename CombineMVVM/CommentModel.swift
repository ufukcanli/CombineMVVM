//
//  CommentModel.swift
//  CombineMVVM
//
//  Created by Ufuk Canlı on 30.03.2022.
//

import Foundation

struct Comment: Decodable {
    let id: Int
    let name: String
    let email: String
}
