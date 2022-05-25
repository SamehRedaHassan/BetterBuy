//
//  FloatingBarView.swift
//  BetterBuy
//
//  Created by user222682 on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit


import UIKit

protocol FloatingBarViewDelegate: AnyObject {
    func did(selectindex: Int)
}

class FloatingBarView: UIView {

    weak var delegate: FloatingBarViewDelegate?

    var buttons: [UIButton] = []

    init(_ items: [String]) {
        super.init(frame: .zero)
        backgroundColor = .white

        setupStackView(items)
        updateUI(selectedIndex: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = .zero
        layer.shadowRadius = bounds.height / 2
    }

    func setupStackView(_ items: [String]) {
        for (index, item) in items.enumerated() {
            let symbolConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .medium)
            let normalImage = UIImage(systemName: item, withConfiguration: symbolConfig)
            let selectedImage = UIImage(systemName: "\(item).fill", withConfiguration: symbolConfig)
            let button = createButton(normalImage: normalImage!, selectedImage: selectedImage!, index: index)
            buttons.append(button)
        }

        let stackView = UIStackView(arrangedSubviews: buttons)

        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
    }

    func createButton(normalImage: UIImage, selectedImage: UIImage, index: Int) -> UIButton {
        let button = UIButton()
        button.constrainWidth(constant: 60)
        button.constrainHeight(constant: 60)
        button.setImage(normalImage, for: .normal)
        button.setImage(selectedImage, for: .selected)
        button.tag = index
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(changeTab(_:)), for: .touchUpInside)
        return button
    }

    @objc
    func changeTab(_ sender: UIButton) {
        sender.pulse()
        delegate?.did(selectindex: sender.tag)
        updateUI(selectedIndex: sender.tag)
    }

    func updateUI(selectedIndex: Int) {
        for (index, button) in buttons.enumerated() {
            if index == selectedIndex {
                button.isSelected = true
//                if index == 0 {
//                    button.tintColor = .red
//                } else {
                    button.tintColor = .black
//                }
            } else {
                button.isSelected = false
                button.tintColor = .gray
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func toggle(hide: Bool) {
        if !hide {
            isHidden = hide
        }

        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1,
                       initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.alpha = hide ? 0 : 1
            self.transform = hide ? CGAffineTransform(translationX: 0, y: 10) : .identity
        }) { (_) in
            if hide {
                self.isHidden = hide
            }
        }
    }
}

extension UIButton {

    func pulse() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        layer.add(pulse, forKey: "pulse")
    }
}
