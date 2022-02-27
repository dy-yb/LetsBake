//
//  TimerModel.swift
//  LetsBake
//
//  Created by Daye on 2022/01/19.
//

import Foundation

struct Time {
  var hour: Int
  var minute: Int
  var second: Int
  
  func toString() -> String {
    let hourToString = String(format: "%02d", hour)
    let minuteToString = String(format: "%02d", minute)
    let secondToString = String(format: "%02d", second)
    
    return "\(hourToString):\(minuteToString):\(secondToString)"
  }
}
