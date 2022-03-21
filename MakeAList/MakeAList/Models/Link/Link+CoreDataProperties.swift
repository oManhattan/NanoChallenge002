//
//  Link+CoreDataProperties.swift
//  MakeAList
//
//  Created by Matheus Cavalcanti de Arruda on 21/03/22.
//
//

import Foundation
import CoreData


extension Link {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Link> {
        return NSFetchRequest<Link>(entityName: "Link")
    }

    @NSManaged public var name: String?
    @NSManaged public var url: String?

}

extension Link : Identifiable {

}
