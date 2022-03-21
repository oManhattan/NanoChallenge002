//
//  ProductList+CoreDataClass.swift
//  MakeAList
//
//  Created by Matheus Cavalcanti de Arruda on 21/03/22.
//
//

import Foundation
import CoreData
import UIKit

@objc(ProductList)
public class ProductList: NSManagedObject {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private func save(){
        do {
            try context.save()
        } catch {}
    }
    
    func createProduct(name: String) {
        let p = ProductList(context: context)
        p.name = name
        save()
    }
    
    func deleteProduct(item: ProductList) {
        context.delete(item)
        save()
    }
    
    func updateProduct(newName: String, item: ProductList) {
        item.name = newName
        save()
    }
    
    func getAllItems() {
        do {
            try context.fetch(ProductList.fetchRequest())
        } catch {}
    }
    
}
