//
//  DirayModel.swift
//  LetsBake
//
//  Created by Daye on 2022/03/03.
//

import Foundation
import RealmSwift
//
//struct Ingredients: Codable {
//  let ingredientName: String
//  let quantity: Int
//  let unit: String
//}

class Diary: Object {
  @Persisted(primaryKey: true) var idx: Int
  @Persisted var title: String
  @Persisted var date: String
  @Persisted var image: String
//  @Persisted var ingredients: [Ingredients]
  @Persisted var receipe: String
  @Persisted var rating: Int

  convenience init(
    idx: Int,
    title: String,
    date: String,
    image: String,
    receipe: String,
    rating: Int
  ) {
    self.init()

    self.idx = idx
    self.title = title
    self.date = date
    self.image = image
    self.receipe = receipe
    self.rating = rating
  }

  override static func primaryKey() -> String? {
    return "idx"
  }

  func dateToString(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy년 MM월 dd일 a hh시 mm분"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.string(from: date)
  }
}

//
//class Ingredients: Object {
//  @Persisted(primaryKey: true) var idx: String?
//  @Persisted var ingredientName: String
//  @Persisted var quantity: Int
//  @Persisted var unit: String
//
//  convenience init(
//    idx: String,
//    ingredientName: String,
//    quantity: Int,
//    unit: String
//  ){
//    self.init()
//
//    self.idx = idx
//    self.ingredientName = ingredientName
//    self.quantity = quantity
//    self.unit = unit
//  }
//
//}
