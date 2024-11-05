//
//  MovelViewController.swift
//  MarcioYukio_RM86662_Mod5
//
//  Created by Marcio Yukio on 04/11/24.
//

import UIKit
import CoreData

class MovelViewController: UIViewController {
    
    @IBOutlet var txtMovel: UITextField!
    @IBOutlet var txtPrice: UITextField!
    @IBOutlet var txtSize: UITextField!
    @IBOutlet var txtMaterial: UITextField!
    
    var movelVindoDaTable:NSObject?=nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if movelVindoDaTable != nil {
            txtMovel.text = movelVindoDaTable?.value(forKey: "movel") as? String
            txtPrice.text = movelVindoDaTable?.value(forKey: "price") as? String
            txtSize.text = movelVindoDaTable?.value(forKey: "size") as? String
            txtMaterial.text = movelVindoDaTable?.value(forKey: "material") as? String
        }
    }
    
    @IBAction func salvar(_ sender: Any) {
        save(movel: txtMovel.text!, price: txtPrice.text!, size: txtSize.text!, material: txtMaterial.text!)
        self.navigationController?.popViewController(animated: true)
    }
    
    func save(movel:String, price:String, size:String, material:String) {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appdelegate.persistentContainer.viewContext
        let entidade = NSEntityDescription.entity(forEntityName: "Movel", in: managedContext)!
        let novoMovel = NSManagedObject(entity: entidade, insertInto: managedContext)
        if (movelVindoDaTable == nil) {
            novoMovel.setValue(movel, forKey: "movel")
            novoMovel.setValue(price, forKey: "price")
            novoMovel.setValue(size, forKey: "size")
            novoMovel.setValue(material, forKey: "material")
        } else {
            let objectUpdate = movelVindoDaTable
            objectUpdate!.setValue(movel, forKey: "movel")
            objectUpdate!.setValue(price, forKey: "price")
            objectUpdate!.setValue(size, forKey: "size")
            objectUpdate!.setValue(material, forKey: "material")
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Não foi possível salvar \(error) \(error.userInfo)")
        }
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
