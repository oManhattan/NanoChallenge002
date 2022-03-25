//
//  MainListViewController.swift
//  MeAjudaDeus
//
//  Created by Matheus Cavalcanti de Arruda on 24/03/22.
//

import UIKit

class MainListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Variáveis
    var mainList = [[CDMainList]]()
    
    // Variáveis ViewController
    @IBOutlet weak var listTable: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    // Funções botões
    // Ação para abrir o menu de opções
    @IBAction func editTable() {
        if listTable.isEditing == true {
            editButton.title = "Edit"
            listTable.isEditing = false
        } else {
            editButton.title = "OK"
            listTable.isEditing = true
        }
    }
    
    // Ação para adicionar lista
    @IBAction func addList() {
        if listTable.isEditing == true {
            editButton.title = "Edit"
            listTable.isEditing = false
        }
        
        let addListViewController = storyboard?.instantiateViewController(withIdentifier: "addListViewController") as! AddListViewController
        addListViewController.update = {
            self.mainList = CDMainList().getLists()
            DispatchQueue.main.async {
                self.listTable.reloadData()
            }
        }
        navigationController?.pushViewController(addListViewController, animated: true)
    }
    
    // ----------------------------------- //
    private func delete(rowIndexPath indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Deletar") { [weak self] (_,_,_) in
            guard let self = self else {return}
            self.listTable.beginUpdates()
            CDMainList().delete(cdMainList: self.mainList[indexPath.section][indexPath.row])
            self.listTable.deleteRows(at: [indexPath], with: .fade)
            self.mainList = CDMainList().getLists()
            self.listTable.reloadData()
            self.listTable.endUpdates()
        }
        return action
    }
    
    private func edit(rowIndexPath indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Editar") { [weak self] (_,_,_) in
            guard let self = self else {return}
            
            let editMainListViewController = self.storyboard?.instantiateViewController(withIdentifier: "editMainListViewController") as! EditMainListViewController
            editMainListViewController.selectedList = self.mainList[indexPath.section][indexPath.row]
            editMainListViewController.update = {
                self.mainList = CDMainList().getLists()
                DispatchQueue.main.async {
                    self.listTable.reloadData()
                }
            }
            self.navigationController?.pushViewController(editMainListViewController, animated: true)
        }
        return action
    }
    // TableView Delegate
    // Ação para quando selecionar uma linha
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let productListViewController = storyboard?.instantiateViewController(withIdentifier: "productListViewController") as! ProductListViewController
        productListViewController.selectedList = mainList[indexPath.section][indexPath.row]
        navigationController?.pushViewController(productListViewController, animated: true)
        
        listTable.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = self.edit(rowIndexPath: indexPath)
        let delete = self.delete(rowIndexPath: indexPath)
        let swipe = UISwipeActionsConfiguration(actions: [delete, edit])
        return swipe
    }
    
    // Função para determinar o nome de cada seção
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Favoritos"
        case 1:
            return "Listas"
        default:
            return "-------"
        }
    }
    
    // Determinar o estilo de edição
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    
    // Arrastar listas
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let sourceList = mainList[sourceIndexPath.section][sourceIndexPath.row]
        
        if sourceIndexPath.section == destinationIndexPath.section {
            let destinationList = mainList[destinationIndexPath.section][destinationIndexPath.row]
            
            CDMainList().swapLists(firstList: sourceList, secondList: destinationList)
            
            mainList = CDMainList().getLists()
            listTable.reloadData()
        } else {
            CDMainList().changeFavoriteStatus(cdMainList: sourceList)
            
            mainList = CDMainList().getLists()
            listTable.reloadData()
        }
    }
    
    // TableView DataSource
    // Atribuir valor para cada linha
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTable.dequeueReusableCell(withIdentifier: "cell01", for: indexPath)
        cell.textLabel?.text = mainList[indexPath.section][indexPath.row].name
        return cell
    }
    
    // Número de linhas por seção
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainList[section].count
    }
    
    // Número de seções
    func numberOfSections(in tableView: UITableView) -> Int {
        return mainList.count
    }

    // Ações que acontecem ao abrir a janela
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ViewController
        self.title = "Make a List"
        view.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
        
        // TableView
        listTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell01")
        listTable.delegate = self
        listTable.dataSource = self
        
        // Variáveis
        mainList = CDMainList().getLists()
        
        //Navigation Controller
        self.editButton.title = "Editar"
    }
}
