//
//  Character.swift
//  takeHomeMarc
//
//  Created by Reo Ogundare on 12/19/24.
//

import Foundation
import UIKit

struct Character: Codable {
    let name: String
    let height: String
    let hair_color: String
    let films: [String]
}

protocol CharacterDelegate {
    func showDetailsPopover(character: Character) -> Void
    func getCharacters() -> Characters
    func getSelectedCharacter() -> Character?
}

