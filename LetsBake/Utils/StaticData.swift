//
//  IngredientsRatio.swift
//  LetsBake
//
//  Created by Daye on 2022/02/20.
//

import Foundation

let ingredientsRatio = [
  ExchangerModel.Ratio(ingredient: "밀가루", quantityAsUnits: ExchangerModel.Units(papercup: 0.01, gram: 1, killogram: 0.001, teaspoon: 0.33333, tablespoon: 0.11111, cup: 0.00704, ounce: 0.03571, fluidOunce: 0.05555, milliliter: 2, liter: 0.002, pound: 0.00220)),
  ExchangerModel.Ratio(ingredient: "쌀가루", quantityAsUnits: ExchangerModel.Units(papercup: 0.01, gram: 1, killogram: 0.001, teaspoon: 0.4, tablespoon: 0.08333, cup: 0.008, ounce: 0.036, fluidOunce: 0.416, milliliter: 1, liter: 0.001, pound: 0.002)),
  ExchangerModel.Ratio(ingredient: "우유", quantityAsUnits: ExchangerModel.Units(papercup: 0.006, gram: 1, killogram: 0.001, teaspoon: 0.2, tablespoon: 0.07, cup: 0.004, ounce: 0.035, fluidOunce: 0.033, milliliter: 1, liter: 0.001, pound: 0.002))]

let staticIngredients = ["밀가루", "쌀가루", "우유"]
let staticUnits = ["종이컵", "그램", "킬로그램", "티스푼", "테이블스푼", "컵", "온스", "액량온스", "밀리리터", "리터", "파운드"]
