//
//  Ratio.swift
//  LetsBake
//
//  Created by Daye on 2021/12/07.
//

import Foundation

struct RatioTest: Codable {
  let ingredient: String
  let quantityAsUnits: Units
}

struct UnitsTest: Codable {
  let papercup: Float?
  let gram: Float
  let killogram: Float
  let teaspoon: Float
  let tablespoon: Float
  let cup: Float
  let ounce: Float
  let fluidOunce: Float
  let milliliter: Float
  let liter: Float
  let pound: Float
}



struct Units {
  let papercup: Float?
  let gram: Float
  let killogram: Float
  let teaspoon: Float
  let tablespoon: Float
  let cup: Float
  let ounce: Float
  let fluidOunce: Float
  let milliliter: Float
  let liter: Float
  let pound: Float
}

struct Ratio {
  let ingredient: String
  let quantityAsUnits: Units
}


// let ingredients = ["밀가루", "쌀가루", "우유", "물", "소금", "흑설탕", "백설탕", "슈가파우더", "바닐라익스트랙", "베이킹소다", "베이킹파우더", "버터", "이스트", "꿀", "아몬드가루"]

let resultArray: [Int] = []

struct ExchangerResult {
  let unitName: String
  let resultValue: Float
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
