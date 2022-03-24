//
//  MainList+CoreDataClass.swift
//  MakeAList
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 23/03/22.
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
    
    private func fetchItems() -> [MainList]{
        var items: [MainList] = []
        do {
            items = try context.fetch(MainList.fetchRequest())
        } catch {}
        
        return items
    }
    
    func getAllItems() -> [[MainList]] {
        let aux = fetchItems()
        
        var listaFavoritos: [MainList] = []
        var listaLista: [MainList] = []
        
        
        
        var listaFinal: [[MainList]] = []
        
        
        
        for item in aux {
            if item.isFavorito == true {
                
                listaFavoritos.append(item)
            } else {
                listaLista.append(item)
            }
        }
        
        listaFinal.append(listaFavoritos)
        listaFinal.append(listaLista)
        
        return listaFinal
    }
    
    func createList(id: Int64, name: String) {
        let newItem = MainList(context: context)
        newItem.idMainList = id
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
    
    func changeSection(item: MainList) {
        
        if item.isFavorito == true {
            item.isFavorito = false
        } else {
            item.isFavorito = true
        }
    }
    
    func changeItems(firstItem: MainList, secondItem: MainList) {
        let auxName = firstItem.name
        let auxList = firstItem.idMainList
        
        firstItem.name = secondItem.name
        firstItem.idMainList = secondItem.idMainList
        
        secondItem.name = auxName
        secondItem.idMainList = auxList
        save()
    }
}
