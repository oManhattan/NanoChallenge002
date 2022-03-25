//
//  CDProduct+CoreDataClass.swift
//  MeAjudaDeus
//
//  Created by Matheus Cavalcanti de Arruda on 24/03/22.
//

import Foundation
import CoreData
import UIKit

@objc(CDProduct)
public class CDProduct: NSManagedObject {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private func save() {
        do { try context.save() } catch {}
    }
    
    private func getLastPid() -> Int64{
        let temp = getAllItems()
        
        var higher: Int64 = 0
        
        if temp.isEmpty {
            return 0
        } else {
            for item in temp {
                if item.pid > higher {
                    higher = item.pid
                }
            }
        }
        
        return higher
    }
    
    public func getAllItems() -> [CDProduct] {
        var temp = [CDProduct]()
        
        do {
            temp = try context.fetch(CDProduct.fetchRequest())
        } catch {}
        
        return temp
    }
    
    //--------------------------------------------------------//
    
    // Criar um produto
    public func create(name: String, id: Int64) {
        let newProduct = CDProduct(context: context)
        
        newProduct.id = id
        newProduct.name = name
        newProduct.isDone = false
        newProduct.pid = getLastPid() + 1
        
        save()
    }
    
    // Alterar nome produto
    public func updateName(name: String, product: CDProduct) {
        product.name = name
        
        save()
    }
    
    // Deletar produto
    public func delete(product: CDProduct) {
        let temp = CDLink().getAllItems()
        
        for i in temp {
            if i.pid == product.pid {
                CDLink().delete(link: i)
            }
        }
        
        context.delete(product)
        
        save()
    }
    
    // Alterar status isDone
    public func changeIsDone(product: CDProduct) {
        if product.isDone == true {
            product.isDone = false
        } else {
            product.isDone = true
        }
        
        save()
    }
    
    // Trocar dois itens de lugar
    public func swapProduct(firstProduct: CDProduct, secondProduct: CDProduct) {
        let temp = firstProduct
        
        firstProduct.name = secondProduct.name
        
        secondProduct.name = temp.name
    }
    
    // Receber todos os produtos que estão relacionados a um id
    public func getProducts(whereID id: Int64) -> [[CDProduct]] {
        let temp = getAllItems()
        
        var isDone = [CDProduct]()
        var isNotDone = [CDProduct]()
        
        for i in temp {
            if i.isDone == true && i.id == id{
                isDone.append(i)
            } else if i.isDone == false && i.id == id {
                isNotDone.append(i)
            }
        }
        
        var finalProductList = [[CDProduct]]()
        finalProductList.append(isDone)
        finalProductList.append(isNotDone)
        
        return finalProductList
    }
}
