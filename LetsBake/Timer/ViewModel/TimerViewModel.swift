//
//  TimerViewModel.swift
//  LetsBake
//
//  Created by Daye on 2022/01/19.
//

import Foundation

protocol ObeservableViewModelProtocol {
  associatedtype T

  func calculateTimeCount(inputTime: Time) -> Int
  var storage: Observable<T> { get set }
  // 에러 메세지
  var errorMessage: Observable<String?> { get set }
  
  // 에러
  var error: Observable<Bool> { get set }
  
}

class TimerViewModel: ObeservableViewModelProtocol {


  var storage: Observable<Time> = Observable(Time(hour: 0, minute: 0, second: 0))

  var errorMessage: Observable<String?> = Observable(nil)

  var error: Observable<Bool> = Observable(false)

  typealias T = Time

  private var time = Time(hour: 0, minute: 0, second: 0)
  private var timeCount: Int = 0

  func calculateTimeCount(inputTime: Time) -> Int {
    let currentSecond = (inputTime.hour * 3600) + (inputTime.minute * 60) + inputTime.second
    
    return currentSecond
  }

  func setTimeLabel(hour: Int, minute: Int, second: Int) -> String {
    let hourToString = String(format: "%02d", hour)
    let minuteToString = String(format: "%02d", minute)
    let secondToString = String(format: "%02d", second)

    return "\(hourToString):\(minuteToString):\(secondToString)"
  }
}
