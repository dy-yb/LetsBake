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
  func fetchData(inputIngredient: String, inputUnit: String, inputQuantity: Double, resultUnit: String) -> Double
  
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
  typealias T = Ratio
  var storage: Observable<[Ratio]> = Observable([])
  var errorMessage: Observable<String?> = Observable(nil)
  var error: Observable<Bool> = Observable(false)

  func setError(_ message: String) {
    //
  }

  func fetchData(inputIngredient: String, inputUnit: String, inputQuantity: Double, resultUnit: String) -> Double {
    var resultQuantity: Double = 0
    let repository = Repository()

    repository.getData { response in
      self.storage = Observable(response)
    }
    for index in 0 ... storage.value.count-1 {
      if inputIngredient == storage.value[index].ingredient {
        let ratio: Units = storage.value[index].quantityAsUnits
        if inputUnit != "gram" {
          let exchangeToGram = inputQuantity / ratio.mutate(inputUnit: inputUnit)
          resultQuantity = exchangeToGram * ratio.mutate(inputUnit: resultUnit)
        } else {
          resultQuantity = inputQuantity * ratio.mutate(inputUnit: resultUnit)
        }
      }
    }
    return resultQuantity
  }
}
