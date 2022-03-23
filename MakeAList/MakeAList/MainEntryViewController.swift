//
//  MainEntryViewController.swift
//  MakeAList
//
//  Created by Matheus Cavalcanti de Arruda on 21/03/22.
//

import UIKit

class MainEntryViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var inputField: UITextField!
    
    var update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Nova lista"
        inputField.delegate
        inputField.placeholder = "Nome lista"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Criar", style: .done, target: self, action: #selector(saveNewElement))
    }
    
    @objc func saveNewElement() {
        guard let text = inputField.text, !text.isEmpty else {
         return
        }
        MainList().createList(name: text)
        update?()
        navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
}
