//
//  Ratio.swift
//  LetsBake
//
//  Created by Daye on 2021/12/07.
//

import Foundation

struct Units {
  // let gram: Float
  let teaspoon: Float
  let tablespoon: Float
  let cup: Float
  let ounce: Float
  let milliliter: Float
}

//class Ratio {
//  // 모든 단위는 1g 기준으로 계산 되어있음
//  // soft flour = 박력분 midium flour = 중력분 strong flour = 강력분
//  let softFlourRatio = Units(teaspoon: 0.13, tablespoon: 0.4, cup: 0.01, ounce: 0.04, milliliter: 2)
//  let midiumFlourRatio = Units(teaspoon: 0.36, tablespoon: 0.12, cup: 0.01, ounce: 0.04, milliliter: 1.82)
//  let strongFlourRatio = Units(teaspoon: 0.3, tablespoon: 0.1, cup: 0.01, ounce: 0.04, milliliter: 1.49)
//}

func returnRatios() -> [Units] {
  let softFlourRatio = Units(teaspoon: 0.13, tablespoon: 0.4, cup: 0.01, ounce: 0.04, milliliter: 2)
  let midiumFlourRatio = Units(teaspoon: 0.36, tablespoon: 0.12, cup: 0.01, ounce: 0.04, milliliter: 1.82)
  let strongFlourRatio = Units(teaspoon: 0.3, tablespoon: 0.1, cup: 0.01, ounce: 0.04, milliliter: 1.49)

  return [softFlourRatio, midiumFlourRatio, strongFlourRatio]
}
