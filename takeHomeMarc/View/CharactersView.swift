//
//  CharactersView.swift
//  takeHomeMarc
//
//  Created by Reo Ogundare on 12/19/24.
//

import Foundation
import UIKit

class CharactersView: UIView {
    private var charactersTableView: UITableView
    var characters: Characters?
    private var resultsIsEmpty: Bool = false
    
    var delegate: CharacterDelegate?
    
    override init(frame: CGRect) {
        charactersTableView = UITableView(frame: frame, style: .plain)
        super.init(frame: frame)
        charactersTableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        
        
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
        addSubview(charactersTableView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints(){
        charactersTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            charactersTableView.topAnchor.constraint(equalTo: topAnchor),
            charactersTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            charactersTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            charactersTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func update() {
        DispatchQueue.main.async { [self] in
            characters = delegate?.getCharacters()
            charactersTableView.reloadData()
        }
    }
}

extension CharactersView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let results = characters?.results, let delegate = delegate {
            if !resultsIsEmpty {
                delegate.showDetailsPopover(character: results[indexPath.row])
            }
        }
    }
}

extension CharactersView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = characters?.results?.count else {
            resultsIsEmpty = true
            return 1
        }
        resultsIsEmpty = false
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = charactersTableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)", for: indexPath as IndexPath)
        if let content = characters?.results {
            cell.textLabel?.text = "\(content[indexPath.row].name)"
        } else {
                cell.textLabel?.text = "No Data Found"
            }
        
        return cell
    }

}
