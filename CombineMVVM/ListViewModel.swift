//
//  ListViewModel.swift
//  CombineMVVM
//
//  Created by Ufuk Canlı on 29.03.2022.
//

import Combine

final class ListViewModel: ObservableObject {
    
    let title = "Animals"
    
    let objectWillChange = PassthroughSubject<Void, Never>()

    private(set) var animals: [Animal] = []
        
//    @Published private(set) var animals: [Animal] = []
    
    func fetch() {
        NetworkManager.getAnimals { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let animals):
                self.animals = animals
                self.objectWillChange.send()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
