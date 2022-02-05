//
//  Ratio.swift
//  LetsBake
//
//  Created by Daye on 2021/12/07.
//

import Foundation

struct QuantityPerOneGram {
  let papercup: Float?
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
  let units: QuantityPerOneGram
}

let input: Int = 300

let ingredients = ["밀가루", "쌀가루", "우유", "물", "소금", "흑설탕", "백설탕", "슈가파우더", "바닐라익스트랙", "베이킹소다", "베이킹파우더", "버터", "이스트", "꿀", "아몬드가루"]

let ingredientsRatio = [
  Ratio(ingredient: "밀가루", units: QuantityPerOneGram(papercup: 0.01, killogram: 0.001, teaspoon: 0.333, tablespoon: 0.125, cup: 0.008, ounce: 0.035, fluidOunce: 0.061, milliliter: 2, liter: 0.002, pound: 0.002)),
  Ratio(ingredient: "쌀가루", units: QuantityPerOneGram(papercup: 0.01, killogram: 0.001, teaspoon: 0.4, tablespoon: 0.125, cup: 0.008, ounce: <#T##Float#>, fluidOunce: <#T##Float#>, milliliter: , liter: <#T##Float#>, pound: <#T##Float#>))]

// func returnRatios() -> [Units] {
//  let softFlourRatio = Units(ingredient: "박력분", teaspoon: 0.13, tablespoon: 0.4, cup: 0.01, ounce: 0.04, milliliter: 2)
//  let midiumFlourRatio = Units(ingredient: "중력분", teaspoon: 0.36, tablespoon: 0.12, cup: 0.01, ounce: 0.04, milliliter: 1.82)
//  let strongFlourRatio = Units(ingredient: "강력분", teaspoon: 0.3, tablespoon: 0.1, cup: 0.01, ounce: 0.04, milliliter: 1.49)
//
//  return [softFlourRatio, midiumFlourRatio, strongFlourRatio]
// }
