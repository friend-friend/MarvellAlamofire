//
//  ViewController.swift
//  MarvellAlamofire
//
//  Created by Вячеслав Онучин on 18.03.2023.
//

import UIKit

class ViewController: UIViewController {
    var netWorkingService = NetworkService()
    var marvellAnswer = [MarvellAnswer]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        netWorkingService.getData(url: netWorkingService.addURL()) { result in
            switch result {

            case .success(let data):
                self.marvellAnswer.append(data)
                print(self.marvellAnswer.first?.data?.results.first?.name)
            case .failure(let error):
                print(error)
            }
        }
    }
}

