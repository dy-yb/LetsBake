//
//  DirayModel.swift
//  LetsBake
//
//  Created by Daye on 2022/03/03.
//

import Foundation
import RealmSwift

class DiaryModel: Object {
  @Persisted(primaryKey: true) var idx: Int
  @Persisted var title: String
  @Persisted var date: String
  @Persisted var image: String
//  @Persisted var ingredients: List<IngredientModel>
  @Persisted var receipe: String
  @Persisted var rating: Int
  let ingredients = List<Ingredient>()

  convenience init(
    idx: Int,
    title: String,
    date: String,
    image: String,
//    ingredients: List<IngredientModel>,
    receipe: String,
    rating: Int
  ) {
    self.init()

    self.idx = idx
    self.title = title
    self.date = date
    self.image = image
//    self.ingredients.append(objectsIn: ingredients)
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

// 같은 모양의 object class 생성
class Ingredient: Object {
  @Persisted var ingredientName: String
  @Persisted var quantity: Int
  @Persisted var unit: String
  let diary = LinkingObjects(fromType: DiaryModel.self, property: "ingredients")

  convenience init(
    ingredientName: String,
    quantity: Int,
    unit: String
  ) {
    self.init()

    self.ingredientName = ingredientName
    self.quantity = quantity
    self.unit = unit
  }
}
