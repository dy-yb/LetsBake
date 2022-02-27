//
//  Ratio.swift
//  LetsBake
//
//  Created by Daye on 2021/12/07.
//

import Foundation

enum UnitString: String {
  case papercup = "종이컵"
  case gram = "그램"
  case killogram = "킬로그램"
  case teaspoon = "티스푼"
  case tablespoon = "테이블스푼"
  case cup = "컵"
  case ounce = "온스"
  case fluidOunce = "액량온스"
  case milliliter = "밀리리터"
  case liter = "리터"
  case pound = "파운드"
}

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

//    init() {
//      papercup = 0
//      gram = 0
//      killogram = 0
//      teaspoon = 0
//      tablespoon = 0
//      cup = 0
//      ounce = 0
//      fluidOunce = 0
//      milliliter = 0
//      liter = 0
//      pound = 0
//    }

    func mutate(inputUnit: String) -> Double {
      switch inputUnit {
      case UnitString.papercup.rawValue:
        return papercup
      case UnitString.gram.rawValue:
        return gram
      case UnitString.killogram.rawValue:
        return killogram
      case UnitString.teaspoon.rawValue:
        return teaspoon
      case UnitString.tablespoon.rawValue:
        return tablespoon
      case UnitString.cup.rawValue:
        return cup
      case UnitString.ounce.rawValue:
        return ounce
      case UnitString.fluidOunce.rawValue:
        return fluidOunce
      case UnitString.milliliter.rawValue:
        return milliliter
      case UnitString.liter.rawValue:
        return liter
      case UnitString.pound.rawValue:
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
