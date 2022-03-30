//
//  ListViewModel.swift
//  CombineMVVM
//
//  Created by Ufuk Canlı on 29.03.2022.
//

import Combine

final class ListViewModel: ObservableObject {
    
    let title = "Comments"
    
    let commentListPublisher = PassthroughSubject<Void, Never>()
    private(set) var comments: [Comment] = []
    
    let loadingStatePublisher = PassthroughSubject<Bool, Never>()
    private(set) var isLoading: Bool = false
        
//    @Published private(set) var comments: [Comment] = []
//    @Published private(set) var isLoading: Bool = false
//
//    func fetch() {
//        isLoading = true
//        let randomInt = Int.random(in: 0..<100)
//        NetworkManager.getComments(by: randomInt) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let comments):
//                self.comments = comments
//                self.isLoading = false
//            case .failure(let error):
//                print(error.localizedDescription)
//                self.isLoading = false
//            }
//        }
//    }
    
    func fetch() {
        isLoading = true
        loadingStatePublisher.send(true)
        let randomInt = Int.random(in: 0..<100)
        NetworkManager.getComments(by: randomInt) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let comments):
                self.comments = comments
                self.commentListPublisher.send()
                self.isLoading = false
                self.loadingStatePublisher.send(false)
            case .failure(let error):
                print(error.localizedDescription)
                self.isLoading = false
                self.loadingStatePublisher.send(false)
            }
        }
    }
}
