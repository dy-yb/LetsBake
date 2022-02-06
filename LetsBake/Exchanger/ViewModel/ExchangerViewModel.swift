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
  func fetchData(inputIngredient: String, inputUnit: String, inputQuantity: Float)
  
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
  func setError(_ message: String) {
    //
  }

  typealias T = Ratio
  let repository = Repository()
  var resultArray: [Float] = []

  func fetchData(inputIngredient: String, inputUnit: String, inputQuantity: Float) {
    repository.getData { response in
      let observable = Observable(response)
      self.storage = observable
    }
    for index in 0 ... storage.value.count {
      if(inputUnit != "gram") {
        if(storage.value[index].ingredient == inputIngredient){
          //          resultArray.append([
          //            storage.value[i].quantityAsUnits.papercup * inputQuantity ?? 0
          //          ])
        }
      } else {
      }
    }
  }
  //  var storage: Observable<[Ratio]> = Observable([])
  var storage: Observable<[Ratio]> = Observable([])
  var errorMessage: Observable<String?> = Observable(nil)
  var error: Observable<Bool> = Observable(false)
}
