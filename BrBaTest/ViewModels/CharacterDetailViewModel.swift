//
//  CharacterDetailViewModel.swift
//  BrBaTest
//
//  Created by Sabrina Tardio on 13/02/2021.
//

import Foundation

class CharacterDetailViewModel: DetailViewModel {
    let character: Character
    
    init(character: Character) {
        self.character = character
    }
    
    func getDetail1Text() -> String {
        return "NAME: \(character.name)"
    }
    
    func getDetail2Text() -> String {
        let occupationsString = character.occupation.joined(separator: ", ")
        return "OCCUPATIONS: \(occupationsString)"
    }
    
    func getDetail3Text() -> String {
        return "BIRTHDAY: \(character.birthday)"
    }
    
    func getDetail4Text() -> String {
        return "STATUS: \(character.status)"
    }
    
    func getDetail5Text() -> String {
        return "PORTRAYED: \(character.portrayed)"
    }
    
    func getImageUrlString() -> String {
        return character.img
    }
    
    
}
