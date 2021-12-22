//
//  ViewExtensions.swift
//  MockableUrlSession
//
//  Created by Daniel Marcenco on 21.12.2021.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
