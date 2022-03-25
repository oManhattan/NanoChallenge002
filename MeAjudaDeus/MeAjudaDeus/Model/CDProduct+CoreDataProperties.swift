//
//  CDProduct+CoreDataProperties.swift
//  MeAjudaDeus
//
//  Created by Matheus Cavalcanti de Arruda on 24/03/22.
//
//

import Foundation
import CoreData


extension CDProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDProduct> {
        return NSFetchRequest<CDProduct>(entityName: "CDProduct")
    }

    @NSManaged public var name: String?
    @NSManaged public var linkList: NSObject?
    @NSManaged public var isDone: Bool

}

extension CDProduct : Identifiable {

}
