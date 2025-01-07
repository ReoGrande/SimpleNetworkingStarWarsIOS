//
//  ButtonSelectionView.swift
//  takeHomeMarc
//
//  Created by Reo Ogundare on 1/2/25.
//

import Foundation
import UIKit

class ButtonSelectionView: UIView {
    private let previousButton = UIButton()
    private let nextButton = UIButton()
    private let hStack = UIStackView()
    var delegate: ButtonSelectionDelegate? {
        didSet {
            updateButtonState()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        previousButton.setImage(.remove, for: .normal)
        previousButton.addTarget(self, action: #selector(previousPage), for: .touchUpInside)
        nextButton.setImage(.add, for: .normal)
        nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)

        constructSubviewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constructSubviewConstraints() {
        addSubview(hStack)
        hStack.addArrangedSubview(previousButton)
        hStack.addArrangedSubview(nextButton)
        hStack.axis = .horizontal
        hStack.distribution = .equalSpacing

        hStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: topAnchor),
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor),

        ])
    }
    
    @objc private func nextPage() {
        guard let delegate = delegate else { return }
        delegate.nextSelected()
        updateButtonState()
    }
    
    @objc private func previousPage() {
        guard let delegate = delegate else { return }
        delegate.previousSelected()
        updateButtonState()
    }
    
    private func updateButtonState() {
        guard let delegate = delegate else {
            return
        }

        if delegate.isNextAvailable() == true {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
        
        if delegate.isPreviousAvailable() {
            previousButton.isEnabled = true
        } else {
            previousButton.isEnabled = false
        }
    }
}


protocol ButtonSelectionDelegate {
    func previousSelected()
    func nextSelected()
    func isNextAvailable() -> Bool
    func isPreviousAvailable() -> Bool
}
