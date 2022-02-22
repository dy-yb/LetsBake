//
//  ExchangerViewModel.swift
//  LetsBake
//
//  Created by Daye on 2021/12/09.
//

import Foundation

class ExchangerViewModel {
  let model = ExchangerModel()
  var result: Observable<String> = Observable("")

  func calculator(inputIngredient: String, inputUnit: String, inputQuantity: Double, resultUnit: String) {
    var resultQuantity: Double = 0

    for index in 0 ... ingredientsRatio.count-1 {
      if inputIngredient == ingredientsRatio[index].ingredient {
        let ratio = ingredientsRatio[index].quantityAsUnits
        if inputUnit != "gram" {
          let exchangeToGram = inputQuantity / ratio.mutate(inputUnit: inputUnit)
          resultQuantity = exchangeToGram * ratio.mutate(inputUnit: resultUnit)
        } else {
          resultQuantity = inputQuantity * ratio.mutate(inputUnit: resultUnit)
        }
      }
    }
    resultQuantity = round(resultQuantity * 100) / 100
    
    if resultQuantity.truncatingRemainder(dividingBy: 1) != 0 {
      result.value = String(format: "%.2f", resultQuantity)
    } else {
      result.value = String(Int(resultQuantity))
    }
  }
}
