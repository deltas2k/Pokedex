//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Matthew O'Connor on 10/1/19.
//  Copyright © 2019 Matthew O'Connor. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func updateViews(pokemon: TopLevelDictionary, image: UIImage) {
        DispatchQueue.main.async {
            self.nameLabel.text = pokemon.name
            self.idLabel.text = "\(pokemon.id)"
            self.abilitiesLabel.text = pokemon.abilities[0].ability.name
            self.pokemonImageView.image = image
        }
    }
   
}

extension PokemonViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        PokemonController.fetchPokemon(with: searchText) { (pokemon) in
            //now that i have a pokemon i can get the image
            guard let pokemon = pokemon else {return}
            PokemonController.getImage(pokemon: pokemon) { (image) in
                guard let image = image else {return}
                self.updateViews(pokemon: pokemon, image: image)
            }
        }
    }
}
