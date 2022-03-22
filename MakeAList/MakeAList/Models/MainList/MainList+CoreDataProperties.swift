//
//  MainList+CoreDataProperties.swift
//  MakeAList
//
//  Created by Wellinston Oliveira on 22/03/22.
//
//

import Foundation
import CoreData


extension MainList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainList> {
        return NSFetchRequest<MainList>(entityName: "MainList")
    }

    @NSManaged public var name: String?
    @NSManaged public var productList: NSObject?
    @NSManaged public var isFavorito: Bool

}

extension MainList : Identifiable {

}
