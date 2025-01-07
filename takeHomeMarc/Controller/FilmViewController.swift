//
//  FilmViewController.swift
//  takeHomeMarc
//
//  Created by Reo Ogundare on 12/19/24.
//

import Foundation
import UIKit

//  Controls the view for the relevant film information for the selected character
class FilmViewController: UIViewController {
    private let padding: CGFloat = 30
    var delegate: CharacterDelegate?
    var films = [Film]() {
        didSet {
            DispatchQueue.main.async {
                self.films.forEach({
                    let tempView = FilmView(film: $0)
                    self.stack.addArrangedSubview(tempView)
                })
            }
        }
    }
    private var scrollView = UIScrollView()
    private var stack = UIStackView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildFilms()
        scrollView.addSubview(stack)
        view.addSubview(scrollView)
        view.isOpaque = true
        view.backgroundColor = .systemBackground
        constructSubviewConstraints()
    }

//    Aggregates films per single character
    private func buildFilms() {
        guard let tempFilms = delegate?.getSelectedCharacter()?.films else {
            return
        }
        films = []
        _ = tempFilms.map({
            let url = URL(string: $0)
            if let url = url {
                let request = URLRequest(url: url)
                
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let data = data {
                        self.films.append(try! JSONDecoder().decode(Film.self, from: data))
                    }
                }
                .resume()
            }
            return url
        })
    }
    
    private func constructSubviewConstraints() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        stack.spacing = padding
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.heightAnchor.constraint(equalTo: stack.heightAnchor),

            stack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

        ])
    }
}
