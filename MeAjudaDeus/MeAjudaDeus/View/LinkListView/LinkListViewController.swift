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
    
    // Função botões
    @objc func openMenu() {
        
    }
    
    @IBAction func addLink() {
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
    
    // Deletar produtos
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            linkTable.beginUpdates()
            linkList.remove(at: indexPath.row)
            linkTable.deleteRows(at: [indexPath], with: .fade)
            linkList = CDLink().getLinks(wherePid: selectedProduct.pid)
            linkTable.reloadData()
            linkTable.endUpdates()
        }
    }
    
    // TableView DataSource
    // Quantidade de células
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        linkList.count
    }
    
    // Atribuindo o valor para cada célula
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = linkTable.dequeueReusableCell(withIdentifier: "cell03", for: indexPath)
        cell.textLabel?.text = linkList[indexPath.row].name
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
        
        // Navigation Controller
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "•••", style: .plain, target: self, action: #selector(openMenu))
    }
}
