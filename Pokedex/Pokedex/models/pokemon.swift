//
//  pokemon.swift
//  Pokedex
//
//  Created by Matthew O'Connor on 10/1/19.
//  Copyright © 2019 Matthew O'Connor. All rights reserved.
//

import Foundation
import UIKit

struct TopLevelDictionary: Decodable {
    private enum CodingKeys: String, CodingKey { //naming specific, must be exhaustive
        case abilities
        case name
        case id
        case spriteDict = "sprites"
        
    }
    
    let abilities: [AbilityDict]
    let name: String
    let id: Int
    let spriteDict: SpriteDict
    
}

struct SpriteDict: Decodable {
    private enum CodingKeys: String, CodingKey {
        case image = "front_shiny"
    }
    let image: URL
}

struct AbilityDict: Decodable {
    let ability: Ability
}

struct Ability: Decodable {
    let name: String
}
