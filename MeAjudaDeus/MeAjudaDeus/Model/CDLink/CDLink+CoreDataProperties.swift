//
//  CDLink+CoreDataProperties.swift
//  MeAjudaDeus
//
//  Created by Matheus Cavalcanti de Arruda on 25/03/22.
//
//

import Foundation
import CoreData


extension CDLink {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDLink> {
        return NSFetchRequest<CDLink>(entityName: "CDLink")
    }

    @NSManaged public var name: String
    @NSManaged public var link: String
    @NSManaged public var pid: Int64

}

extension CDLink : Identifiable {

}
