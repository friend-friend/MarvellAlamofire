//
//  SceneDelegate.swift
//  MarvellAlamofire
//
//  Created by Вячеслав Онучин on 18.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let viewController = Builder.createMainView()
        //        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}

