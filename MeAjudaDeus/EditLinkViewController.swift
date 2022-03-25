//
//  EditLinkViewController.swift
//  MeAjudaDeus
//
//  Created by Matheus Cavalcanti de Arruda on 25/03/22.
//

import UIKit

class EditLinkViewController: UIViewController {

    var selectedLink = CDLink()
    
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var inputField: UITextField!
    
    @IBOutlet weak var instructionField02: UILabel!
    @IBOutlet weak var inputFieldForReal: UITextField!
    
    var update: (() -> Void)?
    
    @objc func changeInformation() {
        guard let text = inputField.text, !text.isEmpty else {
            return
        }
        
        guard let textLink = inputFieldForReal.text, !textLink.isEmpty else {
            return
        }
        
        CDLink().updateName(name: text, link: selectedLink)
        CDLink().updateLink(newLink: textLink, link: selectedLink)
        update?()
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Editar", style: .done, target: self, action: #selector(changeInformation))
        
        inputField.placeholder = "Nome"
        inputField.text = selectedLink.name
        
        instructionLabel.text = "Insira um novo nome para o link \(selectedLink.name)"
        instructionLabel.textAlignment = .center
        
        inputFieldForReal.placeholder = "URL"
        inputFieldForReal.text = selectedLink.link
        
        instructionField02.text = "Insira um novo link"
        instructionField02.textAlignment = .center
        
        self.title = "Editar Link"
    }

}
