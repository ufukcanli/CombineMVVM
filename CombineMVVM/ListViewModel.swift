//
//  ListViewModel.swift
//  CombineMVVM
//
//  Created by Ufuk Canlı on 29.03.2022.
//

import Foundation

final class ListViewModel: ObservableObject {
    
    let title = "Comments"
    
    private(set) var comments: [Comment] = []
    
}
