//
//  DiaryMO+CoreDataProperties.swift
//  
//
//  Created by Daye on 2022/10/11.
//
//

import Foundation
import CoreData


extension DiaryMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiaryMO> {
        return NSFetchRequest<DiaryMO>(entityName: "Diary")
    }

    @NSManaged public var creationDate: String?
    @NSManaged public var date: Date?
    @NSManaged public var ingredients: [String]?
    @NSManaged public var photo: String?
    @NSManaged public var rating: Int16
    @NSManaged public var receipe: String?
    @NSManaged public var title: String?

}
