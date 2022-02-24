//
//  TimerModel.swift
//  LetsBake
//
//  Created by Daye on 2022/01/19.
//

import Foundation

class TimerModel {
  var timeCount = 0

  struct Time {
    var hour: Int
    var minute: Int
    var second: Int

    func toString(time: Time) -> String {
      let hourToString = String(format: "%02d", time.hour)
      let minuteToString = String(format: "%02d", time.minute)
      let secondToString = String(format: "%02d", time.second)

      return "\(hourToString):\(minuteToString):\(secondToString)"
    }
  }

  func toSecond(time: Time) -> Int {
    return ((time.hour * 3600) + (time.minute * 60) + time.second)
  }
}
