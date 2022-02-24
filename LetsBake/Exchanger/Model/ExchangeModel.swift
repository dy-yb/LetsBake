//
//  Ratio.swift
//  LetsBake
//
//  Created by Daye on 2021/12/07.
//

import Foundation

class ExchangerModel {
  struct Units {
    let papercup: Double
    let gram: Double
    let killogram: Double
    let teaspoon: Double
    let tablespoon: Double
    let cup: Double
    let ounce: Double
    let fluidOunce: Double
    let milliliter: Double
    let liter: Double
    let pound: Double

    func mutate(inputUnit: String) -> Double {
      switch inputUnit {
      case "종이컵":
        return papercup
      case "그램":
        return gram
      case "킬로그램":
        return killogram
      case "티스푼":
        return teaspoon
      case "테이블스푼":
        return tablespoon
      case "컵":
        return cup
      case "온스":
        return ounce
      case "액량온스":
        return fluidOunce
      case "밀리리터":
        return milliliter
      case "리터":
        return liter
      case "파운드":
        return pound
      default:
        return 0
      }
    }
  }

  struct Ratio {
   let ingredient: String
   let quantityAsUnits: Units
  }
}
