//
//  CDMainList+CoreDataProperties.swift
//  MeAjudaDeus
//
//  Created by Matheus Cavalcanti de Arruda on 24/03/22.
//
//

import Foundation
import CoreData


extension CDMainList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDMainList> {
        return NSFetchRequest<CDMainList>(entityName: "CDMainList")
    }

    @NSManaged public var isFavorito: Bool
    @NSManaged public var name: String
    @NSManaged public var id: Int64

}

extension CDMainList : Identifiable {

}
