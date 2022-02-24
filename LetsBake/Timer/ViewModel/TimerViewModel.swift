//
//  TimerViewModel.swift
//  LetsBake
//
//  Created by Daye on 2022/01/19.
//

import Foundation

class TimerViewModel {
  let timerModel = TimerModel()
  var time: Observable<String> = Observable("00:00:00")
//  var timeCount = 0

  func setTimeCount(hour: Int, minute: Int, second: Int) -> Int {
    return (hour * 3600) + (minute * 60) + second
  }

  func setTimeLabel(timeCount: Int) {
    let countSec = timeCount % 60
    let countMin = (timeCount / 60) % 60
    let countHour = timeCount / 3600
    let currentTime = TimerModel.Time(hour: countHour, minute: countMin, second: countSec)
  
    time.value = currentTime.toString(time: currentTime)
    }

//  @objc func timer(hour: Int, minute: Int, second: Int){
//    let inputTime = Time(hour: hour, minute: minute, second: second)
//
//  }

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
