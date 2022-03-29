//
//  AnimalModel.swift
//  CombineMVVM
//
//  Created by Ufuk Canlı on 29.03.2022.
//

import Foundation

struct Animal {
    let name: String
    let emoji: String
}

extension Animal {
    static let dog = Animal(name: "Dog", emoji: "🐶")
    static let cat = Animal(name: "Cat", emoji: "🐱")
    static let frog = Animal(name: "Frog", emoji: "🐸")
    static let panda = Animal(name: "Panda", emoji: "🐼")
    static let lion = Animal(name: "Lion", emoji: "🦁")
}
