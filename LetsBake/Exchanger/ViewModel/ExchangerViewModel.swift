//
//  ExchangerViewModel.swift
//  LetsBake
//
//  Created by Daye on 2021/12/09.
//

import Foundation

protocol ObeservableExchangerViewModelProtocol {
  associatedtype T
  // 데이터를 가져옵니다.
  func fetchData()

  // 에러를 처리합니다.
  func setError(_ message: String)

  // 원본데이터
  var storage: Observable<[T]> { get set }

  // 에러 메세지
  var errorMessage: Observable<String?> { get set }

  // 에러
  var error: Observable<Bool> { get set }

}

class ObservableExchangerViewModel: ObeservableExchangerViewModelProtocol {
  typealias T = QuantityAsUnits

  func fetchData() {
    //
  }

  func setError(_ message: String) {
    //
  }

  var storage: Observable<[QuantityAsUnits]> = Observable([])

  var errorMessage: Observable<String?> = Observable(nil)

  var error: Observable<Bool> = Observable(false)

}
