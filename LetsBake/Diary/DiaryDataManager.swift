//
//  DiaryDataManager.swift
//  LetsBake
//
//  Created by Daye on 2022/06/13.
//

import UIKit

import CoreData

class DiaryDataManager {

  static let shared = DiaryDataManager()

  var container: NSPersistentContainer?
  var context: NSManagedObjectContext {
    guard let context = container?.viewContext else { fatalError() }
    return context
  }

  func setup(modelName: String) {
    container = NSPersistentContainer(name: modelName)
    container?.loadPersistentStores(completionHandler: { (description, error) in
      if let error = error {
        print(error)
      }
    })
  }

  func saveContext() {
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }

  func createDiary(diary: DiaryModel) {
    let entity = NSEntityDescription.entity(forEntityName: "Diary", in: context)

    let newDiary = NSManagedObject(entity: entity!, insertInto: context)
    newDiary.setValue(diary.title, forKey: "title")
    newDiary.setValue(stringToDate(stringDate: diary.date), forKey: "date")
    newDiary.setValue(diary.photo, forKey: "photo")
    newDiary.setValue(diary.receipe, forKey: "receipe")
    newDiary.setValue(diary.rating, forKey: "rating")
    newDiary.setValue(diary.ingredients, forKey: "ingredients")

    do {
      try context.save()
    } catch {
      print(error.localizedDescription)
    }
  }

  func fetchDiary() -> [DiaryModel] {
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Diary")
    let result = try! context.fetch(fetchRequest)

    var diaryList: [DiaryModel] = []

    result.forEach({
      diaryList.append(
        DiaryModel(
          title: $0.value(forKey: "title") as? String ?? "",
          date: dateToString(date: $0.value(forKey: "date") as? Date),
          photo: $0.value(forKey: "photo") as? String ?? "",
          receipe: $0.value(forKey: "receipe") as? String ?? "",
          rating: $0.value(forKey: "rating") as? Int ?? 0,
          ingredients: $0.value(forKey: "ingredients") as? [String] ?? []
      ))
    })
    print(diaryList)
    return diaryList
  }

  func dateToString(date: Date?) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd a hh:mm"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.string(from: date ?? Date())
  }

  func stringToDate(stringDate: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd a hh:mm"
    formatter.locale = Locale(identifier: "ko_KR")
    return formatter.date(from: stringDate) ?? Date()
  }

  func updateDiary() {

  }

  func deleteDiary() {
  }

}
