//
//  ViewController.swift
//  MakeAList
//
//  Created by Matheus Cavalcanti de Arruda on 14/03/22.
//

import UIKit

var lista: [MainList] = MainList().getAllItems()

class ViewController: UIViewController {
    
    @IBOutlet weak var mainTable: UITableView!
    
    @IBAction func didTapAppList(_ sender: Any) {
        let entry = storyboard?.instantiateViewController(withIdentifier: "mainEntryViewController") as! MainEntryViewController
        entry.title = "Nova lista"
        entry.update = {
            lista = MainList().getAllItems()
            DispatchQueue.main.async {
                self.mainTable.reloadData()
            }
        }
        navigationController?.pushViewController(entry, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Make a List"
        
        mainTable.delegate = self
        mainTable.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editarTabela))
    }
    
    @objc func editarTabela() {
        if mainTable.isEditing {
            mainTable.setEditing(false, animated: true)
        } else {
            mainTable.setEditing(true, animated: true)
        }
    }
}

// Table View

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainTable.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Favoritos"
        case 1:
            return "Listas"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            MainList().deleteList(item: lista[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
            lista = MainList().getAllItems()
            tableView.endUpdates()
        }
    }
}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lista.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = mainTable.dequeueReusableCell(withIdentifier: "celula01")
        cell?.textLabel?.text = lista[indexPath.row].name
        return cell!
    }
}
