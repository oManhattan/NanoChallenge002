//
//  CDProduct+CoreDataProperties.swift
//  MeAjudaDeus
//
//  Created by Matheus Cavalcanti de Arruda on 25/03/22.
//
//

import Foundation
import CoreData


extension CDProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDProduct> {
        return NSFetchRequest<CDProduct>(entityName: "CDProduct")
    }

    @NSManaged public var id: Int64
    @NSManaged public var isDone: Bool
    @NSManaged public var pid: Int64
    @NSManaged public var name: String

}

extension CDProduct : Identifiable {

}
