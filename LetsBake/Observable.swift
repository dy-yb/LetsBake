//
//  Observable.swift
//  LetsBake
//
//  Created by Daye on 2022/01/27.
//

import Foundation

class Observable<T> {
  var value: T {
    didSet {
      listner?(value)
    }
  }

  private var listner: ((T) -> Void)?

  init(_ value: T) {
    self.value = value
  }

  func bind(_ closure: @escaping (T) -> Void) {
    closure(value)
    listner = closure
  }
}
