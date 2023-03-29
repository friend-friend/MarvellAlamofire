//
//  DescriptionPresenter.swift
//  MarvellAlamofire
//
//  Created by Вячеслав Онучин on 28.03.2023.
//

import Foundation

protocol DescriptionProtocol {
    func configurate(by model: Character?)
}

protocol DescriptionViewMainProtocol {
    var model: Character { get set }
    init(view: DescriptionProtocol, model: Character)
}

class DescriptionViewPresenter: DescriptionViewMainProtocol {
    var model: Character
    var view: DescriptionProtocol
    
    required init(view: DescriptionProtocol, model: Character) {
        self.view = view
        self.model = model
    }
}
