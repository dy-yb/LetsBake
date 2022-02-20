//
//  Observable.swift
//  LetsBake
//
//  Created by Daye on 2022/01/27.
//

import Foundation

class Observable<T> {
  // value definition
  var value: T {
    didSet {
      // 값을 받아 이벤트 수행
      self.listener?(value)
    }
  }

  private var listener: ((T) -> Void)? // 이벤트 저장 할 클로저 변수

  init(_ value: T) {
    self.value = value // value 초기화
  }

  func subscribe(listener: @escaping (T) -> Void) {
    listener(value) // 이벤트 실행
    self.listener = listener // 이벤트를 didSet에서 실행하기 위해 저장
  }
}
