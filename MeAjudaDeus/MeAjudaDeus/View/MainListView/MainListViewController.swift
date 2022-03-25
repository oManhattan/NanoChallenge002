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
    
    // Funções botões
    // Ação para abrir o menu de opções
    @objc func openMenu() {
        
    }
    
    // Ação para adicionar lista
    @IBAction func addList() {
        let addListViewController = storyboard?.instantiateViewController(withIdentifier: "addListViewController") as! AddListViewController
        
        addListViewController.update = {
            self.mainList = CDMainList().getLists()
            DispatchQueue.main.async {
                self.listTable.reloadData()
            }
        }
        
        navigationController?.pushViewController(addListViewController, animated: true)
    }
    
    // TableView Delegate
    // Ação para quando selecionar uma linha
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let productListViewController = storyboard?.instantiateViewController(withIdentifier: "productListViewController") as! ProductListViewController
        productListViewController.selectedList = mainList[indexPath.section][indexPath.row]
        navigationController?.pushViewController(productListViewController, animated: true)
        
        listTable.deselectRow(at: indexPath, animated: true)
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
        let destinationList = mainList[destinationIndexPath.section][destinationIndexPath.row]
        
        if sourceIndexPath.section == destinationIndexPath.section {
            CDMainList().swapLists(firstList: sourceList, secondList: destinationList)
            mainList = CDMainList().getLists()
            listTable.reloadData()
        } else {
            CDMainList().changeFavoriteStatus(cdMainList: sourceList)
            mainList = CDMainList().getLists()
            listTable.reloadData()
        }
    }
    
    // Deletar listas
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listTable.beginUpdates()
            CDMainList().delete(cdMainList: mainList[indexPath.section][indexPath.row])
            listTable.deleteRows(at: [indexPath], with: .fade)
            mainList = CDMainList().getLists()
            listTable.reloadData()
            listTable.endUpdates()
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
        
        // TableView
        listTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell01")
        listTable.delegate = self
        listTable.dataSource = self
        
        // Navigation Controller
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "•••", style: .plain, target: self, action: #selector(openMenu))
        
        // Variáveis
        mainList = CDMainList().getLists()
    }
}
