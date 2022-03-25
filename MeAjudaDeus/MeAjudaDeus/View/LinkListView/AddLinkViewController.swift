//
//  AddLinkViewController.swift
//  MeAjudaDeus
//
//  Created by Matheus Cavalcanti de Arruda on 25/03/22.
//

import UIKit

class AddLinkViewController: UIViewController {

    // Variáveis
    var selectedProduct = CDProduct()
    
    //Variáveis ViewController
    @IBOutlet weak var inputNameField: UITextField!
    @IBOutlet weak var instructionNameLabel: UILabel!
    @IBOutlet weak var inputLinkField: UITextField!
    @IBOutlet weak var instructionLinkLabel: UILabel!
    
    // Funções
    var update: (() -> Void)?
    
    //Verificar se o link é válido
    private func verifyUrl(url: String) -> Bool {
        let temp = URL(string: url)
        return UIApplication.shared.canOpenURL(temp!)
    }
    
    //Função botões
    @objc func createNewLink() {
        guard let nameInput = inputNameField.text, !nameInput.isEmpty else {
            let emptyTextFieldAlert = UIAlertController(title: "Área para nome vazia", message: "Insira um nome para o link.", preferredStyle: .alert)
            emptyTextFieldAlert.addAction(UIAlertAction(title: "Ok", style: .default))
            emptyTextFieldAlert.show(self, sender: self)
            return
        }
        
        guard let nameLink = inputLinkField.text, !nameLink.isEmpty else {
            let emptyTextFieldAlert = UIAlertController(title: "Área para link vazia", message: "Insira um link.", preferredStyle: .alert)
            emptyTextFieldAlert.addAction(UIAlertAction(title: "Ok", style: .default))
            emptyTextFieldAlert.show(self, sender: self)
            return
        }
        
        CDLink().create(name: nameInput, link: nameLink, pid: selectedProduct.pid)
        update?()
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Label
        instructionNameLabel.textAlignment = .center
        instructionNameLabel.text = "Insira um nome para o link"
        
        instructionLinkLabel.textAlignment = .center
        instructionLinkLabel.text = "Insira o link"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Adicionar", style: .done, target: self, action: #selector(createNewLink))
        
        self.title = "Novo Link"
    }
}
