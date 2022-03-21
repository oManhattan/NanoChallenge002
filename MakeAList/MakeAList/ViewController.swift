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
        adicionarTesate()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Make a List"
        
        mainTable.delegate = self
        mainTable.dataSource = self
    }
    
    func adicionarTesate() {
        MainList().createList(name: "teste001")
        MainList().createList(name: "teste002")
        
        lista = MainList().getAllItems()
        
        for i in lista {
            print(i.name)
        }
        
        mainTable.updateConstraints()
    }
}

// Table View

extension ViewController: UITableViewDelegate {
    
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
