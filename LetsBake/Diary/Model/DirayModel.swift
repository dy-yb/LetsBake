//
//  DirayModel.swift
//  LetsBake
//
//  Created by Daye on 2022/03/03.
//

import Foundation

struct DiaryModel {
  var title: String
  var date: String
  var photo: String
  var receipe: String
  var rating: Int
  var ingredients: [String]

  func stringToDate(stringDate: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd a hh:mm"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.date(from: stringDate) ?? Date()
  }

}
