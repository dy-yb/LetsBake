//
//  UIPHPickerConfiguration.swift
//  LetsBake
//
//  Created by Daye on 2022/02/27.
//

import Foundation
import PhotosUI

class PHPicker {
  var phPickerConfiguration = PHPickerConfiguration()

  func config() {
    phPickerConfiguration.selectionLimit = 1
    phPickerConfiguration.filter = .images
  }
}
