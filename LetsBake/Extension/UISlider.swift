//
//  File.swift
//  LetsBake
//
//  Created by Daye on 2022/01/13.
//

import Foundation
import UIKit

class TapUISlider: UISlider {
  override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    let width = self.frame.size.width
    let tapPoint = touch.location(in: self)
    let fPercent = tapPoint.x/width
    let nNewValue = self.maximumValue * Float(fPercent)
    if nNewValue != self.value {
      self.value = nNewValue
    }
    return true
  }
}
