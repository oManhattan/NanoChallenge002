//
//  MainList+CoreDataClass.swift
//  MakeAList
//
//  Created by Matheus Cavalcanti de Arruda on 21/03/22.
//
//

import Foundation
import CoreData
import UIKit

@objc(MainList)
public class MainList: NSManagedObject {
    
    // Funções CRUD
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private func save() {
        do {
            try context.save()
        } catch {}
    }
    
    func getAllItems() -> [[MainList]] {
        var items: [MainList] = []
        do {
            items = try context.fetch(MainList.fetchRequest())
        } catch {}
        
        var favoritos: [MainList] = []
        var noFavoritos: [MainList] = []
        var output: [[MainList]] = [[]]
        
        for i in items {
            if i.isFavorito == true {
                favoritos.append(i)
            } else {
                noFavoritos.append(i)
            }
        }
        
        output.append(favoritos)
        output.append(noFavoritos)
        
        return output
    }
    
    func createList(name: String) {
        let newItem = MainList(context: context)
        newItem.name = name
        newItem.isFavorito = false
        save()
    }
    
    func deleteList(item: MainList) {
        context.delete(item)
        save()
    }
    
    func updateName(item: MainList, newName: String) {
        item.name = newName
        save()
    }

    func removeFavorite(item: MainList) {
        if item.isFavorito == true { item.isFavorito = false }
    }
    
    func addFavorite(item: MainList) {
        if item.isFavorito == false { item.isFavorito = true }
    }
    
    func changeItems(firstItem: MainList, secondItem: MainList) {
        let auxName = firstItem.name
        let auxList = firstItem.productList
        
        firstItem.name = secondItem.name
        firstItem.productList = secondItem.productList
        
        secondItem.name = auxName
        secondItem.productList = auxList
        save()
    }
}
