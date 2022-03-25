//
//  AddProductViewController.swift
//  MeAjudaDeus
//
//  Created by Matheus Cavalcanti de Arruda on 24/03/22.
//

import UIKit

class AddProductViewController: UIViewController {

    // Variáveis
    var selectedList = CDMainList()
    
    // Variáveis ViewController
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var instructionLabel: UILabel!
    
    // Funções
    var update: (() -> Void)?
    
    //Funções botões
    @objc func createProduct() {
        guard let textInput = inputTextField.text, !textInput.isEmpty else {
            let emptyTextFieldAlert = UIAlertController(title: "Área para desejo vazia", message: "Insira um nome para o desejo.", preferredStyle: .alert)
            emptyTextFieldAlert.addAction(UIAlertAction(title: "Ok", style: .default))
            emptyTextFieldAlert.show(self, sender: self)
            return
        }
        
        CDProduct().create(name: textInput, id: selectedList.id)
        update?()
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        instructionLabel.text = "Insira o desejo"
        instructionLabel.textAlignment = .center
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Criar", style: .done, target: self, action: #selector(createProduct))
        
        self.title = "Novo Desejo"
    }
}
