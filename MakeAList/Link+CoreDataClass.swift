//
//  Link+CoreDataClass.swift
//  MakeAList
//
//  Created by Matheus Cavalcanti de Arruda on 21/03/22.
//
//

import Foundation
import CoreData
import UIKit

@objc(Link)
public class Link: NSManagedObject {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private func save() {
        do {
            let item = try context.save()
        } catch {}
    }
    
    func createLink(name: String, url: String) {
        let item = Link(context: context)
        item.name = name
        item.url = url
        save()
    }
    
    func deleteLink(item: Link) {
        context.delete(item)
        save()
    }
    
    func updateLink(item: Link, newName: String, newUrl: String) {
        item.name = newName
        item.url = newUrl
        save()
    }
    
    func getAllItems() {
        do {
            let item = try context.fetch(Link.fetchRequest())
        } catch {}
    }
}
