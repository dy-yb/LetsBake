//
//  DirayModel.swift
//  LetsBake
//
//  Created by Daye on 2022/03/03.
//

import Foundation
import RealmSwift

class DiaryModel: Object {
  @objc var idx: Int = 0
  @objc var title: String = ""
  @objc var date: String = ""
  @objc var image: String = ""
  @objc var receipe: String = ""
  @objc var rating: Int = 0
  let ingredients = List<Ingredient>()

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

class Ingredient: Object {
  @objc dynamic var ingredient: String = ""
  let diary = LinkingObjects(fromType: DiaryModel.self, property: "ingredients")

  convenience init(ingredient: String) {
    self.init()
    self.ingredient = ingredient
  }
}
