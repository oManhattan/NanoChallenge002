//
//  CDMainList+CoreDataClass.swift
//  MeAjudaDeus
//
//  Created by Matheus Cavalcanti de Arruda on 24/03/22.
//

import Foundation
import CoreData
import UIKit

@objc(CDMainList)
public class CDMainList:NSManagedObject {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private func save() {
        do { try context.save() } catch {}
    }
    
    private func getAllItems() -> [CDMainList]{
        var temp = [CDMainList]()
        
        do {
            temp = try context.fetch(CDMainList.fetchRequest())
            } catch {}
        
        return temp
    }
    
    private func getLastId() -> Int64 {
        let temp = getAllItems()
        var higher: Int64 = 0
        
        if temp.isEmpty {
            return 0
        } else {
            for item in temp {
                if item.id > higher {
                    higher = item.id
                }
            }
        }
        
        return higher
    }
    
    //--------------------------------------------------------//
    
    // Criar uma nova lista
    public func create(name: String) {
        let newList = CDMainList(context: context)
        
        newList.name = name
        newList.id = getLastId() + 1
        newList.isFavorito = false
        
        save()
    }
    
    // Atualizar o nome da lista
    public func updateName(name: String, list: CDMainList) {
        list.name = name
        save()
    }
    
    // Deletar uma lista
    public func delete(cdMainList: CDMainList) {
        let temp = CDProduct().getAllItems()
        
        for i in temp {
            if i.id == cdMainList.id {
                CDProduct().delete(product: i)
            }
        }
        
        context.delete(cdMainList)
        save()
    }
    
    // Alterar o status de favorito
    public func changeFavoriteStatus(cdMainList: CDMainList) {
        if cdMainList.isFavorito == true {
            cdMainList.isFavorito = false
        } else {
            cdMainList.isFavorito = true
        }
        
        save()
    }
    
    // Trocar duas listas de lugar
    public func swapLists(firstList: CDMainList, secondList: CDMainList) {
        let temp = firstList
        
        firstList.id = secondList.id
        firstList.name = secondList.name
        
        secondList.id = temp.id
        secondList.name = temp.name
        
        save()
    }
    
    // Receber a lista atualizada
    public func getLists() -> [[CDMainList]] {
        let temp = getAllItems()
        
        var favoriteList = [CDMainList]()
        var noFavoriteList = [CDMainList]()
        
        for i in temp {
            if i.isFavorito == true {
                favoriteList.append(i)
            } else {
                noFavoriteList.append(i)
            }
        }
        
        var finalList = [[CDMainList]]()
        finalList.append(favoriteList)
        finalList.append(noFavoriteList)
        
        return finalList
    }
}
