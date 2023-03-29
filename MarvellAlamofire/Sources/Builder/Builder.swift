//
//  Builder.swift
//  MarvellAlamofire
//
//  Created by Вячеслав Онучин on 28.03.2023.
//

import UIKit

protocol BuilderProtocol {
    static func createMainView() -> UIViewController
    static func createDescriptionView(character: Character) -> UIViewController
}

final class Builder: BuilderProtocol {
    static func createDescriptionView(character: Character) -> UIViewController {
        let view = DescriptionViewController()
        let presenter = DescriptionViewPresenter(view: view, model: character)
        view.presenter = presenter
        return view
    }
    
    
    static func createMainView() -> UIViewController {
        let view = ViewController()
        let networkService = NetworkService()
        let presenter = MainViewPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
}
