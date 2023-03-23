//
//  Constraint ext.swift
//  MarvellAlamofire
//
//  Created by Вячеслав Онучин on 21.03.2023.
//

import UIKit

extension UIView {

    func addSubviewsForAutoLayout(_ views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
}
