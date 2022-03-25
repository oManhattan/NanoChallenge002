//
//  LinkListViewController.swift
//  MeAjudaDeus
//
//  Created by Matheus Cavalcanti de Arruda on 25/03/22.
//

import UIKit

class LinkListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Variáveis
    var selectedProduct = CDProduct()
    var linkList = [CDLink]()
    
    
    // Variáveis ViewController
    @IBOutlet weak var linkTable: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    // Função botões
    @IBAction func editTable() {
        if linkTable.isEditing == true {
            editButton.title = "Editar"
            linkTable.isEditing = false
        } else {
            editButton.title = "OK"
            linkTable.isEditing = true
        }
    }
    
    @IBAction func addLink() {
        if linkTable.isEditing == true {
            editButton.title = "Editar"
            linkTable.isEditing = false
        }
        
        let addLinkViewController = storyboard?.instantiateViewController(withIdentifier: "addLinkViewController") as! AddLinkViewController
        addLinkViewController.selectedProduct = self.selectedProduct
        addLinkViewController.update = {
            self.linkList = CDLink().getLinks(wherePid: self.selectedProduct.pid)
            DispatchQueue.main.async {
                self.linkTable.reloadData()
            }
        }
        navigationController?.pushViewController(addLinkViewController, animated: true)
    }
    
    private func delete(rowIndexPath indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Deletar") { [weak self] (_,_,_) in
            guard let self = self else {return}
            self.linkTable.beginUpdates()
            CDLink().delete(link: self.linkList[indexPath.row])
            self.linkList.remove(at: indexPath.row)
            self.linkTable.deleteRows(at: [indexPath], with: .fade)
            self.linkList = CDLink().getLinks(wherePid: self.selectedProduct.pid)
            self.linkTable.reloadData()
            self.linkTable.endUpdates()
        }
        return action
    }
    
    private func edit(rowIndexPath indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Editar") { [weak self] (_,_,_) in
            guard let self = self else {return}
            
            let editLinkViewController = self.storyboard?.instantiateViewController(withIdentifier: "editLinkViewController") as! EditLinkViewController
            editLinkViewController.selectedLink = self.linkList[indexPath.row]
            editLinkViewController.update = {
                self.linkList = CDLink().getLinks(wherePid: self.selectedProduct.pid)
                DispatchQueue.main.async {
                    self.linkTable.reloadData()
                }
            }
            self.navigationController?.pushViewController(editLinkViewController, animated: true)
        }
        return action
    }
    
    // TableView
    // TabelView Delegate
    // Ação para quando uma célula for selecionada
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: linkList[indexPath.row].link) {
            UIApplication.shared.open(url)
        }
        linkTable.deselectRow(at: indexPath, animated: true)
    }
    
    // Função para determinar o nome de cada seção
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Links"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = self.edit(rowIndexPath: indexPath)
        edit.backgroundColor = .link
        let delete = self.delete(rowIndexPath: indexPath)
        let swipe = UISwipeActionsConfiguration(actions: [delete, edit])
        return swipe
    }
    
    // Determinar o estilo de edição
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // Arrastar Produtos
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let sourceLink = linkList[sourceIndexPath.row]
        let destinationLink = linkList[destinationIndexPath.row]
        
        CDLink().swapLink(firstLink: sourceLink, secondLink: destinationLink)
        linkList = CDLink().getLinks(wherePid: selectedProduct.pid)
        
        linkTable.reloadData()
    }
    
    // TableView DataSource
    // Quantidade de células
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        linkList.count
    }
    
    // Atribuindo o valor para cada célula
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = linkTable.dequeueReusableCell(withIdentifier: "cell03", for: indexPath)
        cell.textLabel?.text = "\u{1f517}   \(linkList[indexPath.row].name)"
        return cell
    }
    
    // Ação para quando o ViewController abrir
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Variáveis
        linkList = CDLink().getLinks(wherePid: selectedProduct.pid)
        
        //TableView
        linkTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell03")
        linkTable.delegate = self
        linkTable.dataSource = self
        
        // ViewControler
        self.title = selectedProduct.name
        view.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
        
        // Navigation Controller
        editButton.title = "Editar"
    }
}
