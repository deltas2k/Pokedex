//
//  PokemonController.swift
//  Pokedex
//
//  Created by Matthew O'Connor on 10/1/19.
//  Copyright © 2019 Matthew O'Connor. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {
    static func fetchPokemon(with searchTerm: String, completion: @escaping (TopLevelDictionary?) -> Void) {
        //step 1 - baseURL
        guard let baseURL = URL(string: "https://pokeapi.co/api/v2/") else {return}
        //add first additional component
        let pokemonComponent = baseURL.appendingPathComponent("pokemon")
        //add second additional component
        let finalURL = pokemonComponent.appendingPathComponent(searchTerm)
        print(finalURL)
        
        //perform the dataTask
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
           
            //check for error
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
           
            //check for data
            if let data = data {
                //if i can create a constant from the value of the data returned in the dataTask completetion, then there is data to work with
                do {
                    let pokemon = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                    completion(pokemon)
                } catch {
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    completion(nil); return
                }
            }
        }
    .resume()
    }
    
    static func getImage(pokemon: TopLevelDictionary, completion: @escaping (UIImage?) -> Void) {
        let finalURL = pokemon.spriteDict.image
        let dataTask = URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
            if let data = data {
                guard let image = UIImage(data: data) else {return}
                completion(image)
                }
            }
        .resume()
    }
    
}
