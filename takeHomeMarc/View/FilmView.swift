//
//  FilmView.swift
//  takeHomeMarc
//
//  Created by Reo Ogundare on 1/2/25.
//

import Foundation
import UIKit

class FilmView: UIView {
    private let title = UILabel()
    private let episodeId = UILabel()
    private let director = UILabel()
    private let producer = UILabel()
    private let releaseDate = UILabel()
    private let created = UILabel()
    private let edited = UILabel()
    private let spacing: CGFloat = 30

    init(film: Film) {
        self.title.text = "Title: " + film.title
        self.episodeId.text = "Episode: " + String(film.episode_id)
        self.director.text = "Director: " + film.director
        self.producer.text = "Producer: " + film.producer
        self.releaseDate.text = "Release Date: " + film.release_date
        self.created.text = "Created Time: " + film.created
        self.edited.text = "Edited Time: " + film.edited
        super.init(frame: .zero)
        backgroundColor = .secondarySystemBackground
        constructSubviewConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constructSubviewConstraints() {
        addSubview(title)
        addSubview(episodeId)
        addSubview(director)
        addSubview(producer)
        addSubview(releaseDate)
        addSubview(created)
        addSubview(edited)

        title.translatesAutoresizingMaskIntoConstraints = false
        episodeId.translatesAutoresizingMaskIntoConstraints = false
        director.translatesAutoresizingMaskIntoConstraints = false
        producer.translatesAutoresizingMaskIntoConstraints = false
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        created.translatesAutoresizingMaskIntoConstraints = false
        edited.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: spacing * 5),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            
            episodeId.topAnchor.constraint(equalTo: title.bottomAnchor, constant: spacing),
            episodeId.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            episodeId.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            
            director.topAnchor.constraint(equalTo: episodeId.bottomAnchor, constant: spacing),
            director.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            director.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            
            producer.topAnchor.constraint(equalTo: director.bottomAnchor, constant: spacing),
            producer.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            producer.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            
            releaseDate.topAnchor.constraint(equalTo: producer.bottomAnchor, constant: spacing),
            releaseDate.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            releaseDate.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            
            created.topAnchor.constraint(equalTo: releaseDate.bottomAnchor, constant: spacing),
            created.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            created.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            
            edited.topAnchor.constraint(equalTo: created.bottomAnchor, constant: spacing),
            edited.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            edited.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            edited.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            
        ])
    }
}
