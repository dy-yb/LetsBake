//
//  UIPickerView.swift
//  LetsBake
//
//  Created by Daye on 2022/02/22.
//

import Foundation
import UIKit

extension UIPickerView {
  func setPickerLabelsWith(labels: [String]) {
    let columCount = labels.count
    let fontSize: CGFloat = 23
    
    var labelList: [UILabel] = []
    for index in 0..<columCount {
      let label = UILabel()
      label.text = labels[index]
      label.font = .boldSystemFont(ofSize: 20)
      label.textColor = .mainColor
      label.textAlignment = .left
      label.sizeToFit()
      labelList.append(label)
    }
    
    let pickerWidth: CGFloat = self.frame.width
    let labelY: CGFloat = (self.frame.size.height / 2) - (fontSize / 2)
    
    for (index, label) in labelList.enumerated() {
      let labelX: CGFloat = (pickerWidth / CGFloat(columCount)) * CGFloat(index + 1) - 36
      label.frame = CGRect(x: labelX, y: labelY-7, width: fontSize*2, height: fontSize)
      self.addSubview(label)
    }
  }
}
