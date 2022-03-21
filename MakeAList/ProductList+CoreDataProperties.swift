//
//  ProductList+CoreDataProperties.swift
//  MakeAList
//
//  Created by Matheus Cavalcanti de Arruda on 21/03/22.
//
//

import Foundation
import CoreData


extension ProductList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductList> {
        return NSFetchRequest<ProductList>(entityName: "ProductList")
    }

    @NSManaged public var linkList: NSObject?
    @NSManaged public var name: String?

}

extension ProductList : Identifiable {

}
