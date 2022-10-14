//
//  DiaryViewModel.swift
//  LetsBake
//
//  Created by Daye on 2022/03/03.
//

import Foundation

protocol DiaryViewModelProtocol {
  func dateToString(date: Date?) -> String
}

class DiaryViewModel {

  var diaryDataManager = CoreDataManager.shared

  func dateToString(date: Date?) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd a hh:mm"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.string(from: date ?? Date())
  }
}
