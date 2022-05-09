//
//  tabBarController.swift
//  LetsBake
//
//  Created by Daye on 2022/03/08.
//

import UIKit

class TabBarController: UITabBarController {

  // MARK: - Tab

  enum Tab: Int {
    case diary
    case timer
    case exchanger
  }

  lazy var tabBarItems: [Tab: UITabBarItem] = [
    .diary: UITabBarItem(
      title: "다이어리",
      image: UIImage(named: "ic_diary_50_off"),
      selectedImage: UIImage(named: "ic_diary_50_on")
    ),
    .exchanger: UITabBarItem(
      title: "계량 도우미",
      image: UIImage(named: "ic_exchanger_50_off"),
      selectedImage: UIImage(named: "ic_exchanger_50_on")
    ),
    .timer: UITabBarItem(
      title: "타이머",
      image: UIImage(named: "ic_timer_50_on"),
      selectedImage: UIImage(named: "ic_timer_50_on"))
  ]

  let diaryView = DiaryListViewController()
  let exchangerView = ExchangerViewController()
  let timerView = TimerViewController()

  // MARK: - Initialize

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    attribute()
  }
  
  private func attribute() {
    UITabBar.appearance().layer.applyShadow(color: .gray, alpha: 0.3, shadowX: 0, shadowY: 0, blur: 12)
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray], for: .selected)
    self.tabBar.tintColor = .mainColor
    
    self.diaryView.tabBarItem = self.tabBarItems[.diary]
    self.exchangerView.tabBarItem = self.tabBarItems[.exchanger]
    self.timerView.tabBarItem = self.tabBarItems[.timer]

    let navDiaryView = UINavigationController(rootViewController: diaryView)

    self.setViewControllers([navDiaryView, timerView, exchangerView], animated: false)
  }

}
