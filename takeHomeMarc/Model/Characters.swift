//
//  Characters.swift
//  takeHomeMarc
//
//  Created by Reo Ogundare on 12/19/24.
//

import Foundation
import UIKit

struct Characters: Codable {
    var results: [Character]?
    var next: String?
    private enum Key: String, CodingKey {
        case results = "results"
        case next = "next"
    }

    mutating func addPeople(person: Character) {
        results?.append(person)
    }
}


