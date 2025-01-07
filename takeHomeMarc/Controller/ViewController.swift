//
//  ViewController.swift
//  takeHomeMarc
//
//  Created by Reo Ogundare on 12/19/24.
//

import UIKit

class ViewController: UIViewController {
    private let charactersView = CharactersView(frame: .zero)
    private let buttonSelectionView = ButtonSelectionView(frame: .zero)
    private lazy var characters: Characters = Characters(results: [], next: "") {
        didSet {
                self.charactersView.update()
        }
    }
    
    var selectedCharacter: Character?
    
    private lazy var singleCharacterFilmView = FilmViewController()
    static let urlString = "https://swapi.py4e.com/api/people/"
    private var pageNumber = 1 {
        didSet {
            buildCharacters()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        charactersView.delegate = self
        buttonSelectionView.delegate = self
        view.addSubview(buttonSelectionView)
        view.addSubview(charactersView)
        setupConstraints() 
        buildCharacters()
    }
    
    private func setupConstraints(){
        charactersView.translatesAutoresizingMaskIntoConstraints = false
        buttonSelectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonSelectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            buttonSelectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            buttonSelectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            buttonSelectionView.heightAnchor.constraint(equalToConstant: 50),
            
            charactersView.topAnchor.constraint(equalTo: buttonSelectionView.bottomAnchor),
            charactersView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            charactersView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            charactersView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func buildCharacters() {
        let stringWithSuffix = "\(ViewController.urlString)\(pageNumber != 1 ? "?page=\(String(pageNumber))" : "")"

        let url = URL(string: stringWithSuffix)
        if let url = url {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request){ data, response, error in
                if let data = data {
                    self.characters = try! JSONDecoder().decode(Characters.self, from: data)
                }
            }
            .resume()
        }
    }
    
    private func buildNextPage() {
            pageNumber = pageNumber + 1
    }
    
    private func buildPreviousPage() {
        if isPreviousAvailable() {
            pageNumber = pageNumber - 1
        }
    }
}

    

extension ViewController: CharacterDelegate {
    func showDetailsPopover(character: Character) {
        singleCharacterFilmView = FilmViewController()
        selectedCharacter = character
        singleCharacterFilmView.delegate = self
        
        present(singleCharacterFilmView, animated: true)
    }
    
    func getCharacters() -> Characters {
        return characters
    }
    
    func getSelectedCharacter() -> Character? {
        return selectedCharacter
    }
}

extension ViewController: ButtonSelectionDelegate {
    func isNextAvailable() -> Bool {
        print(characters.next)
        guard let check = characters.next else { return false }
        return true
    }
    
    func isPreviousAvailable() -> Bool {
        pageNumber > 1 ? true : false
    }
    
    @objc func previousSelected() {
        buildPreviousPage()
    }
    
    @objc func nextSelected() {
        buildNextPage()
    }
    
    
}



