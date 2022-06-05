//
//  UIStackView+Extension.swift
//  todo-app-swift-programmatically
//
//  Created by Soultan Muhammad Albar on 04/06/22.
//

import UIKit

extension UIStackView {
    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }
}
