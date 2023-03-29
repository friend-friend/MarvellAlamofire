//
//  MainPresenter.swift
//  MarvellAlamofire
//
//  Created by Вячеслав Онучин on 28.03.2023.
//

import Foundation

protocol MainViewControllerProtocol: AnyObject {
    func reloadData()
}

protocol CustomCellProtocol: AnyObject {
    func configurate(by model: Character?)
}

protocol PresenterProtocol: AnyObject {
    var model: MarvellAnswer? { get set }
    init(view: MainViewControllerProtocol, networkService: NetworkServiceProtocol)
    func getData()
}

class MainViewPresenter: PresenterProtocol {
    weak var view: MainViewControllerProtocol?
    let networkService: NetworkServiceProtocol
    var model: MarvellAnswer?
    
    required init(view: MainViewControllerProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getData()
    }
    
    func getData() {
        networkService.getData(url: networkService.addURL()) { result in
            switch result {
            case .success(let data):
                self.model = data
                self.view?.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
