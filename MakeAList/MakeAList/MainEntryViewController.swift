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
    
    //recebendo id do IdMainList
    var id : Int64?
    
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
        //fazendo uma variavel com guard para caso a variavel seja nula
        let newId : Int64 = id!
       
      
        
        MainList().createList(id: newId, name: text)
        update?()
        navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
}
