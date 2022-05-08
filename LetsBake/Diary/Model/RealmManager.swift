//
//  RealmManager.swift
//  LetsBake
//
//  Created by Daye on 2022/03/13.
//

import Foundation
import RealmSwift

public class RealmManager {
  let realm = try? Realm()

  static func realm() -> Realm? {
    do {
      return try Realm()
    } catch {
      print(error.localizedDescription)
    }
    return nil
  }

  func saveObjects(objc: Object) {
      guard let realm = RealmManager.realm() else { return }
      try? realm.write({
        print("Realm저장위치=\n\(Realm.Configuration.defaultConfiguration.fileURL!)\n")
        realm.add(objc)
      })
  }

  func getObjects(type: Object.Type) -> Results<Object>? {
      return realm?.objects(type)
  }

  func updateObjects(objc: Object) {
    guard let realm = RealmManager.realm() else { return }
    try? realm.write({
      realm.add(objc, update: .modified)
    })
  }

  func deleteObjcets(objc: Object) {
    guard let realm = RealmManager.realm() else { return }
    try? realm.write({
      realm.delete(objc)
    })
  }

  static func incrementID() -> Int {
      guard let realm = RealmManager.realm() else { return 0 }
      return (realm.objects(DiaryModel.self).max(ofProperty: "idx") as Int? ?? 0) + 1
  }
}
