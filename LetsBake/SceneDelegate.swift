//
//  SceneDelegate.swift
//  LetsBake
//
//  Created by Daye on 2021/11/30.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)

    let tabBar = TabBarController()

    let timerModel = Time(hour: 0, minute: 0, second: 0)
    let timerViewModel = TimerViewModel(timerModel: timerModel)
    TabBarController().timerView.timerViewModel = timerViewModel

    let exchangerModel = ExchangerModel()
    let exchangerViewModel = ExchangerViewModel(model: exchangerModel)
    TabBarController().exchangerView.exchangerViewModel = exchangerViewModel

    self.window?.rootViewController = tabBar
    self.window?.windowScene = windowScene
    self.window?.makeKeyAndVisible()
  }
  
  func sceneDidDisconnect(_ scene: UIScene) {
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
  }

  func sceneWillResignActive(_ scene: UIScene) {
  }

  func sceneWillEnterForeground(_ scene: UIScene) {
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
  }
}
