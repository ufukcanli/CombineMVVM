//
//  ListItemCellViewModel.swift
//  CombineMVVM
//
//  Created by Ufuk Canlı on 29.03.2022.
//

import Combine

final class ListItemCellViewModel {
    
    var actionPublisher = PassthroughSubject<String, Never>()
    
    private let animal: Animal
    
    init(animal: Animal) {
        self.animal = animal
    }
    
    var animalName: String {
        return animal.name
    }
    
    var animalEmoji: String {
        return animal.emoji
    }

    func sendEmoji() {
        actionPublisher.send(animalEmoji)
    }
}
