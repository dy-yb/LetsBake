//
//  TimerViewModel.swift
//  LetsBake
//
//  Created by Daye on 2022/01/19.
//

import Foundation

final class TimerViewModel {
  var timerModel: Time
  var time: Observable<String> = Observable("00:00:00")
  
  init(timerModel: Time) {
    self.timerModel = timerModel
  }
  
  func setTimeCount(hour: Int, minute: Int, second: Int) -> Int {
    return (hour * 3600) + (minute * 60) + second
  }
  
  func setTimeLabel(timeCount: Int) {
    timerModel.hour = timeCount / 3600
    timerModel.minute = (timeCount / 60) % 60
    timerModel.second = timeCount % 60
    
    time.value = timerModel.toString()
  }
}
