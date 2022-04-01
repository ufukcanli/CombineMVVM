//
//  ListItemCellViewModel.swift
//  CombineMVVM
//
//  Created by Ufuk Canlı on 29.03.2022.
//

import Combine

final class ListItemCellViewModel {
        
    private let comment: Comment
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    var commentName: String {
        return comment.name
    }
    
    var commentEmail: String {
        return comment.email
    }
}
