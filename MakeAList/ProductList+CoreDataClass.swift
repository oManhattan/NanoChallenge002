//
//  ProductList+CoreDataClass.swift
//  MakeAList
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 24/03/22.
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
    
    func createProduct(name: String, id: Int64) {
        let p = ProductList(context: context)
        p.name = name
        p.idProduct = id
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
    
    func fetchItems()->[ProductList]{
        var items: [ProductList] = []
        do {
            items = try context.fetch(ProductList.fetchRequest())
        } catch {}
        
        return items
    }
    
    func getAllItems() -> [[ProductList]] {
        let aux = fetchItems()
        
        var lista: [ProductList] = []
        
        var listaFinal: [[ProductList]] = []
        
        for item in aux {
            lista.append(item)
        }
        
        listaFinal.append(lista)
        
        return listaFinal
    }
    
    func getAllItemsByIdProduct(id: Int64) -> [[ProductList]] {
        let aux = fetchItems()
        
        var lista: [ProductList] = []
        
        var listaFinal: [[ProductList]] = []
        
        for item in aux {
            if item.idProduct == id {
                lista.append(item)
            }
            
        }
        
        listaFinal.append(lista)
        
        return listaFinal
    }

}
