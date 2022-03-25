//
//  ProductListViewController.swift
//  MeAjudaDeus
//
//  Created by Matheus Cavalcanti de Arruda on 24/03/22.
//

import UIKit

class ProductListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Variáveis
    var selectedList = CDMainList()
    var productList = [[CDProduct]]()
    
    // View Controller Variáveis
    @IBOutlet weak var productTable: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var nav: UINavigationItem!
    
    // Função botões
    @IBAction func openMenu() {
        if productTable.isEditing == true {
            editButton.title = "Editar"
            productTable.isEditing = false
        } else {
            editButton.title = "OK"
            productTable.isEditing = true
        }
    }
    
    @IBAction func addProduct() {
        if productTable.isEditing == true {
            editButton.title = "Editar"
            productTable.isEditing = false
        }
        
        let addProductViewController = storyboard?.instantiateViewController(withIdentifier: "addProductViewController") as! AddProductViewController
        addProductViewController.selectedList = selectedList
        addProductViewController.update = {
            self.productList = CDProduct().getProducts(whereID: self.selectedList.id)
            DispatchQueue.main.async {
                self.productTable.reloadData()
            }
        }
        navigationController?.pushViewController(addProductViewController, animated: true)
    }
    
    // --------------------------------------- //
    private func delete(rowIndexPath indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Deletar") { [weak self] (_,_,_) in
            guard let self = self else {return}
            self.productTable.beginUpdates()
            CDProduct().delete(product: self.productList[indexPath.section][indexPath.row])
            self.productTable.deleteRows(at: [indexPath], with: .fade)
            self.productList = CDProduct().getProducts(whereID: self.selectedList.id)
            self.productTable.reloadData()
            self.productTable.endUpdates()
        }
        return action
    }
    
    private func edit(rowIndexPath indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Editar") { [weak self] (_,_,_) in
            guard let self = self else {return}
            
            let editProductViewController = self.storyboard?.instantiateViewController(withIdentifier: "editProductViewController") as! EditProductViewController
            editProductViewController.selectedProduct = self.productList[indexPath.section][indexPath.row]
            editProductViewController.update = {
                self.productList = CDProduct().getProducts(whereID: self.selectedList.id)
                DispatchQueue.main.async {
                    self.productTable.reloadData()
                }
            }
            self.navigationController?.pushViewController(editProductViewController, animated: true)
        }
        return action
    }
    
    // TableView
    // TableView Delegate
    // Ação para quando uma célula for selecionada
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let linkListViewController = storyboard?.instantiateViewController(withIdentifier: "linkListViewController") as! LinkListViewController
        linkListViewController.selectedProduct = productList[indexPath.section][indexPath.row]
        navigationController?.pushViewController(linkListViewController, animated: true)
        productTable.deselectRow(at: indexPath, animated: true)
    }
    
    // Função para determinar o nome de cada seção
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Realizados"
        case 1:
            return "Desejos"
        default:
            return "--------"
        }
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
    
    // Determinar o estilo de edição
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // Arrastar produtos
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let sourceProduct = productList[sourceIndexPath.section][sourceIndexPath.row]
        
        if sourceIndexPath.section == destinationIndexPath.section {
            let destinationProduct = productList[sourceIndexPath.section][destinationIndexPath.row]
            CDProduct().swapProduct(firstProduct: sourceProduct, secondProduct: destinationProduct)
            productList = CDProduct().getProducts(whereID: selectedList.id)
            productTable.reloadData()
        } else {
            CDProduct().changeIsDone(product: sourceProduct)
            productList = CDProduct().getProducts(whereID: selectedList.id)
            productTable.reloadData()
        }
    }
    
    // TableView DataSourve
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTable.dequeueReusableCell(withIdentifier: "cell02", for: indexPath)
        cell.textLabel?.text = productList[indexPath.section][indexPath.row].name
        return cell
    }
    
    // Ação para quando a View Controller abrir
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation
        self.editButton.title = "Editar"
        
        // View Controller
        view.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
        self.title = selectedList.name
        
        // Iniciando variáveis
        self.productList = CDProduct().getProducts(whereID: selectedList.id)
        
        // TableView
        productTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell02")
        productTable.delegate = self
        productTable.dataSource = self
    }
}
