//
//  ProductList+CoreDataProperties.swift
//  MakeAList
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 24/03/22.
//
//

import Foundation
import CoreData


extension ProductList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductList> {
        return NSFetchRequest<ProductList>(entityName: "ProductList")
    }

    @NSManaged public var idProduct: Int64
    @NSManaged public var name: String?
    @NSManaged public var linkList: [[String]]?

}

extension ProductList : Identifiable {

}
