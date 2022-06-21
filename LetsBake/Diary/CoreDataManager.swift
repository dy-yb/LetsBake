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

  let appDelegate = UIApplication.shared.delegate as! AppDelegate
  lazy var persistentContainer: NSPersistentContainer = {

    let container = NSPersistentContainer(name: "Model")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in

      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })

    return container

  }()

  func saveContext() {
    let context = CoreDataManager.shared.persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }

  func createDiary(diary: DiaryModel) -> Diary? {
    let managedContext = CoreDataManager.shared.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Diary", in: managedContext)
    let newDiary = NSManagedObject(entity: entity!, insertInto: managedContext)
    newDiary.setValue(diary.creationDate, forKey: "creationDate")
    newDiary.setValue(diary.title, forKey: "title")
    newDiary.setValue(diary.date, forKey: "date")
    newDiary.setValue(diary.photo, forKey: "photo")
    newDiary.setValue(diary.recipe, forKey: "receipe")
    newDiary.setValue(diary.rating, forKey: "rating")
    newDiary.setValue(diary.ingredients, forKey: "ingredients")

    do {
      try managedContext.save()
      return newDiary as? DiaryModel
    } catch {
      print(error.localizedDescription)
      return nil
    }
  }

  func fetchDiary() -> [Diary]? {
    let managedContext = CoreDataManager.shared.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Diary")

    var diaryList: [Diary] = []

    do {
      let diary = try managedContext.fetch(fetchRequest)
      return diary as? [DiaryModel]
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
      return nil
    }
  }

  func updateDiary(editedData: DiaryModel, editedDiary: Diary) {
    let context = CoreDataManager.shared.persistentContainer.viewContext

    do {
      editedDiary.setValue(editedData.creationDate, forKey: "creationDate")
      editedDiary.setValue(editedData.title, forKey: "title")
      editedDiary.setValue(editedData.date, forKey: "date")
      editedDiary.setValue(editedData.photo, forKey: "photo")
      editedDiary.setValue(editedData.recipe, forKey: "receipe")
      editedDiary.setValue(editedData.rating, forKey: "rating")
      editedDiary.setValue(editedData.ingredients, forKey: "ingredients")
      do {
        try context.save()
        print("saved!")
      } catch let error as NSError {
        print("Could not save \(error), \(error.userInfo)")
      } catch {

      }

    } catch {
      print("Error with request: \(error)")
    }
  }

  func deleteDiary(creationDate: String) -> [Diary]? {
    let managedContext = CoreDataManager.shared.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Diary")
    fetchRequest.predicate = NSPredicate(format: "creationDate == %@", creationDate)

    do {
      let item = try managedContext.fetch(fetchRequest)
      var updatedDiary = [DiaryModel]()

      for index in item {
        managedContext.delete(index)
        try managedContext.save()
        updatedDiary.append(index as! Diary)
      }

      return updatedDiary
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")

      return nil
    }
  }
}
