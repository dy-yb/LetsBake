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
  
  func configToolbar() {
    let toolBar = UIToolbar(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: UIScreen.main.bounds.width, height: 44)))
    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = true
    toolBar.tintColor = .white
    toolBar.sizeToFit()
    
    let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(donePicker))
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelPicker))
    doneButton.tintColor = .darkGray
    cancelButton.tintColor = .darkGray
    
    toolBar.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true
    
    self.inputAccessoryView = toolBar
  }
  
  @objc func donePicker() {
    self.resignFirstResponder()
  }
  
  @objc func cancelPicker() {
    self.text = nil
    self.resignFirstResponder()
  }
}
