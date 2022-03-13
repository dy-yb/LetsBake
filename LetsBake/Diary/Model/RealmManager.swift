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

  public func getUrl() -> URL? {
    let url = Realm.Configuration.defaultConfiguration.fileURL
    print("Realm Database fileUrl: ", url?.absoluteString)

    return url
  }

  static func realm() -> Realm? {
    do {
      print("Realm저장위치=\n\(Realm.Configuration.defaultConfiguration.fileURL!)\n")
      print(Realm.Configuration.defaultConfiguration.encryptionKey)
      return try Realm()
    } catch {
      print(error.localizedDescription)
    }
    return nil
  }

  func saveObjects(objc: Object) {
      guard let realm = RealmManager.realm() else { return }
      try? realm.write ({
          realm.add(objc)
      })
  }

  func getObjects(type: Object.Type) -> Results<Object>? {
      return realm?.objects(type)
  }

  static func incrementID() -> Int {
      guard let realm = RealmManager.realm() else { return 0 }
      return (realm.objects(Diary.self).max(ofProperty: "idx") as Int? ?? 0) + 1
  }

}
