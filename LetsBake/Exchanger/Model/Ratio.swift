//
//  Ratio.swift
//  LetsBake
//
//  Created by Daye on 2021/12/07.
//

import Foundation
import UIKit

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
}

struct Ratio {
 let ingredient: String
 let quantityAsUnits: Units
 func mutate(inputUnit: String) -> Double {
   switch inputUnit {
   case "종이컵":
     return quantityAsUnits.papercup
   case "그램":
     return quantityAsUnits.gram
   case "킬로그램":
     return quantityAsUnits.killogram
   case "티스푼":
     return quantityAsUnits.teaspoon
   case "테이블스푼":
     return quantityAsUnits.tablespoon
   case "컵":
     return quantityAsUnits.cup
   case "온스":
     return quantityAsUnits.ounce
   case "액량온스":
     return quantityAsUnits.fluidOunce
   case "밀리리터":
     return quantityAsUnits.milliliter
   case "리터":
     return quantityAsUnits.liter
   case "파운드":
     return quantityAsUnits.pound
   default:
     return 0
   }
 }
}

let resultArray: [Int] = []

struct ExchangerResult {
  let unitName: String
  let resultValue: Double
}

let ingredientsRatio = [
  Ratio(ingredient: "밀가루", quantityAsUnits: Units(papercup: 0.01, gram: 1, killogram: 0.001, teaspoon: 0.333, tablespoon: 0.125, cup: 0.008, ounce: 0.035, fluidOunce: 0.061, milliliter: 2, liter: 0.002, pound: 0.002)),
  Ratio(ingredient: "쌀가루", quantityAsUnits: Units(papercup: 0.01, gram: 1, killogram: 0.001, teaspoon: 0.4, tablespoon: 0.08333, cup: 0.008, ounce: 0.036, fluidOunce: 0.416, milliliter: 1, liter: 0.001, pound: 0.002)),
  Ratio(ingredient: "우유", quantityAsUnits: Units(papercup: 0.006, gram: 1, killogram: 0.001, teaspoon: 0.2, tablespoon: 0.07, cup: 0.004, ounce: 0.035, fluidOunce: 0.033, milliliter: 1, liter: 0.001, pound: 0.002))]

class Repository {
  /* GET 메소드를 통한 API 통신(가정) */
  func getData(onCompleted: @escaping ([Ratio]) -> Void) {
    /* 만약 통신을 한다면 통신을 모두 하고 난 이후 */
    /* 이스케이핑 클로저를 통해 값을 전달한다. */
    onCompleted(ingredientsRatio)
  }
}
