//
//  MainList+CoreDataProperties.swift
//  MakeAList
//
//  Created by Matheus Cavalcanti de Arruda on 21/03/22.
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

}

extension MainList : Identifiable {

}

