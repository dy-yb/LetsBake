//
//  DiaryDataManager.swift
//  LetsBake
//
//  Created by Daye on 2022/06/13.
//

import UIKit

import CoreData

class CoreDataManager {
  static let shared = CoreDataManager()

  private init() {}

  var container: NSPersistentContainer = {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.persistentContainer
  }()

  lazy var entity = NSEntityDescription.entity(
    forEntityName: "Diary",
    in: self.container.viewContext
  )

  func saveDiary(diary: DiaryModel) {
    let newDiary = NSManagedObject(
      entity: self.entity!,
      insertInto: self.container.viewContext
    )
    newDiary.setValue(diary.creationDate, forKey: "creationDate")
    newDiary.setValue(diary.title, forKey: "title")
    newDiary.setValue(diary.date, forKey: "date")
    newDiary.setValue(diary.photo, forKey: "photo")
    newDiary.setValue(diary.receipe, forKey: "receipe")
    newDiary.setValue(diary.rating, forKey: "rating")
    newDiary.setValue(diary.ingredients, forKey: "ingredients")
    do {
      try self.container.viewContext.save()
    } catch {
      print(error.localizedDescription)
    }
  }

  func fetchDiary() -> [DiaryModel]? {
    do {
      let diary = try self.container.viewContext.fetch(DiaryMO.fetchRequest()) as! [DiaryMO]
      var result: [DiaryModel] = []
      diary.forEach {
        result.append(
          DiaryModel(
            title: $0.title ?? "",
            date: $0.date ?? Date(),
            photo: $0.photo ?? "",
            receipe: $0.receipe ?? "",
            rating: Int($0.rating),
            ingredients: $0.ingredients ?? []
          )
        )
      }
      return result
    } catch {
      print(error.localizedDescription)
      return nil
    }
  }

  func updateDiary(editedData: DiaryMO, editedDiary: DiaryMO) {
    let context = self.container.viewContext

    editedDiary.setValue(editedData.creationDate, forKey: "creationDate")
    editedDiary.setValue(editedData.title, forKey: "title")
    editedDiary.setValue(editedData.date, forKey: "date")
    editedDiary.setValue(editedData.photo, forKey: "photo")
    editedDiary.setValue(editedData.receipe, forKey: "receipe")
    editedDiary.setValue(editedData.rating, forKey: "rating")
    editedDiary.setValue(editedData.ingredients, forKey: "ingredients")
    do {
      try context.save()
      print("saved!")
    } catch let error as NSError {
      print("Could not save \(error), \(error.userInfo)")
    }
  }

  func deleteDiary(creationDate: String) -> [DiaryMO]? {
    let managedContext = self.container.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Diary")
    fetchRequest.predicate = NSPredicate(format: "creationDate == %@", creationDate)

    do {
      let item = try managedContext.fetch(fetchRequest)
      var updatedDiary = [DiaryMO]()

      for index in item {
        managedContext.delete(index)
        try managedContext.save()
        updatedDiary.append(index as! DiaryMO)
      }

      return updatedDiary
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")

      return nil
    }
  }
}

//
//  func createDiary(diary: DiaryModel) -> Diary? {
//    let managedContext = self.viewContext
//    let entity = NSEntityDescription.entity(forEntityName: "Diary", in: managedContext)
//    let newDiary = NSManagedObject(entity: entity!, insertInto: managedContext)
//    newDiary.setValue(diary.creationDate, forKey: "creationDate")
//    newDiary.setValue(diary.title, forKey: "title")
//    newDiary.setValue(diary.date, forKey: "date")
//    newDiary.setValue(diary.photo, forKey: "photo")
//    newDiary.setValue(diary.recipe, forKey: "receipe")
//    newDiary.setValue(diary.rating, forKey: "rating")
//    newDiary.setValue(diary.ingredients, forKey: "ingredients")
//
//    do {
//      try managedContext.save()
//      return newDiary as? DiaryModel
//    } catch {
//      print(error.localizedDescription)
//      return nil
//    }
//  }
//
//  func fetchDiary() -> [Diary]? {
//    let managedContext = CoreDataManager.shared.persistentContainer.viewContext
//    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Diary")
//
//    var diaryList: [Diary] = []
//
//    do {
//      let diary = try managedContext.fetch(fetchRequest)
//      return diary as? [DiaryModel]
//    } catch let error as NSError {
//      print("Could not fetch. \(error), \(error.userInfo)")
//      return nil
//    }
//  }
//
