//
//  EntryProductViewController.swift
//  MakeAList
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 24/03/22.
//

import UIKit

class EntryProductViewController: UIViewController {
    
    @IBOutlet weak var txtFProduct: UITextField!
    var id : Int64?
    var update: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Criar", style: .done, target: self, action: #selector(saveNewProduct))
    }
    
    @objc func saveNewProduct() {
        guard let text = txtFProduct.text, !text.isEmpty else {
         return
        }
        //fazendo uma variavel com guard para caso a variavel seja nula
        let newId : Int64 = id!
       
      
        
        ProductList().createProduct(name: text, id: newId)
        update?()
        navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
