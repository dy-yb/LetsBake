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

    let rootView = DiaryViewController()
    let timerView = TimerViewController()
    let exchangerView = ExchangerViewController()
    let diaryView = UINavigationController(rootViewController: rootView)

    let tabBarController = UITabBarController()
    self.window?.rootViewController = tabBarController

    tabBarController.setViewControllers([diaryView, timerView, exchangerView], animated: false)

    // MARK: TabBar Style

    tabBarController.tabBar.layer.applyShadow(color: .gray, alpha: 0.3, shadowX: 0, shadowY: 0, blur: 12)
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue], for: .selected)

    if let tbc = self.window?.rootViewController as? UITabBarController {
      if let tbItems = tbc.tabBar.items {
        tbItems[0].image = UIImage(named: "ic_diary_50_off")?.withRenderingMode(.alwaysOriginal)
        tbItems[0].selectedImage = UIImage(named: "ic_diary_50_on")?.withRenderingMode(.alwaysOriginal)
        tbItems[0].title = "일지"

        tbItems[1].image = UIImage(named: "ic_timer_50_off")?.withRenderingMode(.alwaysOriginal)
        tbItems[1].selectedImage = UIImage(named: "ic_timer_50_on")?.withRenderingMode(.alwaysOriginal)
        tbItems[1].title = "타이머"

        tbItems[2].image = UIImage(named: "ic_exchanger_50_off")?.withRenderingMode(.alwaysOriginal)
        tbItems[2].selectedImage = UIImage(named: "ic_exchanger_50_on")?.withRenderingMode(.alwaysOriginal)
        tbItems[2].title = "계량 도우미"
      }
      tbc.tabBar.backgroundColor = .white
    }
    window?.makeKeyAndVisible()
  }

  func sceneDidDisconnect(_ scene: UIScene) {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
  }

  func sceneWillResignActive(_ scene: UIScene) {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
  }

  func sceneWillEnterForeground(_ scene: UIScene) {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
  }

}
