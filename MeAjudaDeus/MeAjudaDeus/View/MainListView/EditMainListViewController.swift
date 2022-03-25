//
//  EditMainListViewController.swift
//  MeAjudaDeus
//
//  Created by Matheus Cavalcanti de Arruda on 25/03/22.
//

import UIKit

class EditMainListViewController: UIViewController {
    
    var selectedList = CDMainList()
    
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var inputField: UITextField!
    
    var update: (() -> Void)?
    
    @objc func changeInformation() {
        guard let text = inputField.text, !text.isEmpty else {
            return
        }
        
        CDMainList().updateName(name: text, list: selectedList)
        update?()
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Editar", style: .done, target: self, action: #selector(changeInformation))
        
        inputField.placeholder = "Nome"
        inputField.text = selectedList.name
        
        instructionLabel.text = "Insira um novo nome para a lista \(selectedList.name)"
        instructionLabel.textAlignment = .center
        
        self.title = "Editar Lista"
    }
}
