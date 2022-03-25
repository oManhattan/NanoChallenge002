//
//  AddListViewController.swift
//  MeAjudaDeus
//
//  Created by Matheus Cavalcanti de Arruda on 24/03/22.
//

import UIKit

class AddListViewController: UIViewController {

    // Variáveis View Controller
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var instructionLabel: UILabel!
    
    // Funções
    var update: (() -> Void)?
    
    // Funções botões
    @objc func createList() {
        guard let textInput = inputTextField.text, !textInput.isEmpty else {
            let emptyTextFieldAlert = UIAlertController(title: "Área para nome vazia", message: "Insira um nome para a nova lista.", preferredStyle: .alert)
            emptyTextFieldAlert.addAction(UIAlertAction(title: "Ok", style: .default))
            emptyTextFieldAlert.show(self, sender: self)
            return
        }
        
        CDMainList().create(name: textInput)
        update?()
        navigationController?.popViewController(animated: true)
    }
    
    // Ações para quando a janela abrir
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Label
        instructionLabel.text = "Insira um nome para a nova lista."
        instructionLabel.textAlignment = .center
        
        // Navigation Controller
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Criar", style: .done, target: self, action: #selector(createList))
        
        self.title = "Nova Lista"
    }
}
