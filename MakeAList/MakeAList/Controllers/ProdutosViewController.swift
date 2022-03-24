//
//  ProdutosViewController.swift
//  MakeAList
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 24/03/22.
//

import UIKit

var produtos: [[ProductList]] = ProductList().getAllItemsByIdProduct(id: 1)

class ProdutosViewController: UIViewController {
    
    var id : Int64?
    
    
    func retornaId() -> Int64 {
        return id!
    }
    
    @IBAction func adicionarProduto(_ sender: Any) {
        let entryProduto = storyboard?.instantiateViewController(withIdentifier: "EntryProductViewController") as! EntryProductViewController
        entryProduto.id = id
        entryProduto.update = {
            produtos = ProductList().getAllItemsByIdProduct(id: self.id!)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        navigationController?.pushViewController(entryProduto, animated: true)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        title = "Produtos"

    }

}

extension ProdutosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Produtos"
    }
}

extension ProdutosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        produtos[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        produtos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        produtos = ProductList().getAllItemsByIdProduct(id: self.id!)
        let textinho : String = "\(produtos[indexPath.section][indexPath.row].name!) \(produtos[indexPath.section][indexPath.row].idProduct)"
        cell?.textLabel?.text = textinho
        return cell!
    }
}
