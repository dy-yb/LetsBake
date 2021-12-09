//
//  UITabBar.swift
//  LetsBake
//
//  Created by Daye on 2021/12/09.
//

import Foundation
import UIKit

extension CALayer {
    // Sketch 스타일의 그림자를 생성하는 유틸리티 함수
  func applyShadow(
    color: UIColor = .black,
    alpha: Float = 0.5,
    shadowX: CGFloat = 0,
    shadowY: CGFloat = 2,
    blur: CGFloat = 4
  ) {
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: shadowX, height: shadowY)
    shadowRadius = blur / 2.0
  }
}

extension UITabBar {
    // 기본 그림자 스타일을 초기화해야 커스텀 스타일을 적용할 수 있다.
  static func clearShadow() {
    UITabBar.appearance().shadowImage = UIImage()
    UITabBar.appearance().backgroundImage = UIImage()
    UITabBar.appearance().backgroundColor = UIColor.white
  }
}
