//
//  DirayModel.swift
//  LetsBake
//
//  Created by Daye on 2022/03/03.
//

import Foundation

struct Ingredients {
  let ingredientName: String
  let quantity: Int
  let unit: String
}

struct Diary {
  let title: String
  let date: String
  var image: String {
    return "\(title)_\(date)_image.png"
  }
  var ingredient: [Ingredients]
  var receipe: String
  var rating: Int
}
