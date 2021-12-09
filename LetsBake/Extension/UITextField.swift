//
//  UITextField.swift
//  LetsBake
//
//  Created by Daye on 2021/12/09.
//

import Foundation
import UIKit

extension UITextField {
  func setUnderLineToTextField() {
    let border = CALayer()
    border.frame = CGRect(x: 0, y: frame.size.height-1, width: frame.width, height: 1)
    border.backgroundColor = UIColor.darkGray.cgColor
    layer.addSublayer(border)
    backgroundColor = .white
  }
}
