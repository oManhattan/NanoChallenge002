//
//  IdMainList+CoreDataProperties.swift
//  MakeAList
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 23/03/22.
//
//

import Foundation
import CoreData


extension IdMainList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IdMainList> {
        return NSFetchRequest<IdMainList>(entityName: "IdMainList")
    }

    @NSManaged public var id: Int32

}

extension IdMainList : Identifiable {

}
