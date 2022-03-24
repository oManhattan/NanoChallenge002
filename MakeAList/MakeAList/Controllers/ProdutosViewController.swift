//
//  ProdutosViewController.swift
//  MakeAList
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 24/03/22.
//

import UIKit

class ProdutosViewController: UIViewController {
    

    
    var id : Int64?
    var produtos = [ProductList]()
    
    func getProdutos() -> [ProductList]{
        let temp = ProductList().getAllItemsByIdProduct(id: self.id ?? 0)
        
        return temp
    }
    
    
    @IBAction func adicionarProduto(_ sender: Any) {
        let entryProduto = storyboard?.instantiateViewController(withIdentifier: "EntryProductViewController") as! EntryProductViewController
        entryProduto.id = self.id
        entryProduto.update = {
            self.produtos = self.getProdutos()
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
    }

}

extension ProdutosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ProdutosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        produtos.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        produtos = self.getProdutos()
        let textinho : String = "\(produtos[indexPath.row].name!) \(produtos[indexPath.row].idProduct)"
        cell?.textLabel?.text = textinho
        return cell!
    }
}
