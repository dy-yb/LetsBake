//
//  UIView.swift
//  LetsBake
//
//  Created by Daye on 2021/12/09.
//

import Foundation
import UIKit

extension UIView {
  func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
    clipsToBounds = true
    layer.cornerRadius = cornerRadius
    layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
  }
}
