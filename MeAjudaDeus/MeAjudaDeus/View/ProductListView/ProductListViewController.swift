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
    
    // Função botões
    @objc func openMenu() {
        
    }
    
    @IBAction func addProduct() {
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
    
    // Determinar o estilo de edição
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // Arrastar produtos
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let sourceProduct = productList[sourceIndexPath.section][sourceIndexPath.row]
        let destinationProduct = productList[sourceIndexPath.section][destinationIndexPath.row]
        
        if sourceIndexPath.section == destinationIndexPath.section {
            CDProduct().swapProduct(firstProduct: sourceProduct, secondProduct: destinationProduct)
            productList = CDProduct().getProducts(whereID: selectedList.id)
            productTable.reloadData()
        } else {
            CDProduct().changeIsDone(product: sourceProduct)
            productList = CDProduct().getProducts(whereID: selectedList.id)
            productTable.reloadData()
        }
    }
    
    // Deletar produtos
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            productTable.beginUpdates()
            CDProduct().delete(product: productList[indexPath.section][indexPath.row])
            productTable.deleteRows(at: [indexPath], with: .fade)
            productList = CDProduct().getProducts(whereID: selectedList.id)
            productTable.reloadData()
            productTable.endUpdates()
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
        
        // View Controller
        self.title = ("\(selectedList.name)")
        
        // Iniciando variáveis
        self.productList = CDProduct().getProducts(whereID: selectedList.id)
        
        // Navigation Bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "•••", style: .plain, target: self, action: #selector(openMenu))
        
        // TableView
        productTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell02")
        productTable.delegate = self
        productTable.dataSource = self
    }
}
