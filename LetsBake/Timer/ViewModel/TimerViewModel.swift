//
//  TimerViewModel.swift
//  LetsBake
//
//  Created by Daye on 2022/01/19.
//

import Foundation

class TimerViewModel {
  var time: Observable<String> = Observable("00:00:00")

  func setTimeLabel(inputTime: Time) {
//    let timeCount = (inputHour * 3600) + (inputMinute * 60) + inputSecond

    time.value = inputTime.toString(time: inputTime)
  }

//  func calculateTimeCount(inputTime: Time) -> Int {
//    let currentSecond = (inputTime.hour * 3600) + (inputTime.minute * 60) + inputTime.second
//
//    return currentSecond
//  }
//
//  func setTimeLabel(hour: Int, minute: Int, second: Int) {
//    let hourToString = String(format: "%02d", hour)
//    let minuteToString = String(format: "%02d", minute)
//    let secondToString = String(format: "%02d", second)
//
//    time.value = "\(hourToString):\(minuteToString):\(secondToString)"
//  }



}
