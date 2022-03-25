//
//  CDLink+CoreDataClass.swift
//  MeAjudaDeus
//
//  Created by Matheus Cavalcanti de Arruda on 25/03/22.
//
//

import Foundation
import CoreData
import UIKit

@objc(CDLink)
public class CDLink: NSManagedObject {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private func save() {
        do { try context.save() } catch {}
    }
    
    public func getAllItems() -> [CDLink] {
        var temp = [CDLink]()
        
        do {
            temp = try context.fetch(CDLink.fetchRequest())
        } catch {}
        
        return temp
    }
    
    //--------------------------------------------------------//
    
    // Criar um novo link
    public func create(name: String, link: String, pid: Int64) {
        let newLink = CDLink(context: context)
        newLink.name = name
        newLink.link = link
        newLink.pid = pid
        
        save()
    }
    
    // Deletar um link
    public func delete(link: CDLink) {
        context.delete(link)
        
        save()
    }
    
    // Atualizar o nome
    public func updateName(name: String, link: CDLink) {
        link.name = name
        
        save()
    }
    
    // Atualizar o link
    public func updateLink(newLink: String, link: CDLink) {
        link.link = newLink
        
        save()
    }
    
    // Alterar dois links de lugar
    public func swapLink(firstLink: CDLink, secondLink: CDLink) {
        let auxName = firstLink.name
        let auxLink = firstLink.link
        
        firstLink.name = secondLink.name
        firstLink.link = secondLink.link
        
        secondLink.name = auxName
        secondLink.link = auxLink
    }
    
    // Regatar todos os links com um ID
    public func getLinks(wherePid id: Int64) -> [CDLink] {
        let temp = getAllItems()
        
        var linkList = [CDLink]()
        
        for i in temp {
            if i.pid == id {
                linkList.append(i)
            }
        }
        
        return linkList
    }
}
