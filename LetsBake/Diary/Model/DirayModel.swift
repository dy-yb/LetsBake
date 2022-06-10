//
//  DirayModel.swift
//  LetsBake
//
//  Created by Daye on 2022/03/03.
//

import Foundation

class DiaryModel: Object {
  @objc dynamic var idx: Int = 0
  @objc dynamic var title: String = ""
  @objc dynamic var date: Date = Date()
  @objc dynamic var photo: String = ""
  @objc dynamic var receipe: String = ""
  @objc dynamic var rating: Int = 0
  let ingredients = List<Ingredient>()

  convenience init(
    idx: Int,
    title: String,
    date: Date,
    photo: String,
    receipe: String,
    rating: Int
  ) {
    self.init()

    self.idx = idx
    self.title = title
    self.date = date
    self.photo = photo
    self.receipe = receipe
    self.rating = rating
  }

  override static func primaryKey() -> String? {
    return "idx"
  }

  func dateToString(date: Date?) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd a hh:mm"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.string(from: date ?? Date())
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
