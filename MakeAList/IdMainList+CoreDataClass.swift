//
//  IdMainList+CoreDataClass.swift
//  MakeAList
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 23/03/22.
//
//

import Foundation
import CoreData
import UIKit

@objc(IdMainList)
public class IdMainList: NSManagedObject {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private func save(){
        do {
            try context.save()
        } catch {}
    }
    
    func createIdMainList(id: Int64) {
        let item = IdMainList(context: context)
        item.id = id
        save()
    }
    
    func deleteIdMainList(item: IdMainList) {
        context.delete(item)
        save()
    }
    
    func updateIdMainList(newId: Int64, item: IdMainList) {
        item.id = newId
        save()
    }
    
    func fetchItems()->[IdMainList]{
        var items: [IdMainList] = []
        do {
            items = try context.fetch(IdMainList.fetchRequest())
        } catch {}
        
        return items
    }
    
    func getAllItems() -> [[IdMainList]] {
        let aux = fetchItems()
        
        var lista: [IdMainList] = []
        
        var listaFinal: [[IdMainList]] = []
        
        for item in aux {
            lista.append(item)
        }
        
        listaFinal.append(lista)
        
        return listaFinal
    }
}
