//
//  MainList+CoreDataProperties.swift
//  MakeAList
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 23/03/22.
//
//

import Foundation
import CoreData


extension MainList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainList> {
        return NSFetchRequest<MainList>(entityName: "MainList")
    }

    @NSManaged public var isFavorito: Bool
    @NSManaged public var name: String?
    @NSManaged public var idMainList: Int64

}

extension MainList : Identifiable {

}
