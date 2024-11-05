//
//  MovelTableViewController.swift
//  MarcioYukio_RM86662_Mod5
//
//  Created by Marcio Yukio on 04/11/24.
//

import UIKit
import CoreData

class MovelTableViewController: UITableViewController {
    
    var moveis: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return moveis.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appdelegate.persistentContainer.viewContext
        let fetchRquest = NSFetchRequest<NSManagedObject>(entityName: "Movel")
        fetchRquest.sortDescriptors = [NSSortDescriptor(key: "movel", ascending: true)]
        do {
            moveis = try managedContext.fetch(fetchRquest)
        } catch let error as NSError {
            print("Não foi possível buscar os dados \(error) \(error.userInfo)")
        }
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let movel = moveis[indexPath.row]
        
        cell.textLabel?.text = movel.value(forKey: "movel") as? String
        
        cell.detailTextLabel?.text = movel.value(forKey: "price") as? String

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appdelegate.persistentContainer.viewContext
            managedContext.delete(moveis[indexPath.row])
            do {
                try managedContext.save()
                moveis.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch let error as NSError {
                print("Não foi possível excluir os dados \(error) \(error.userInfo)")
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "TableParaCadastroSegue" {
            let t = segue.destination as! MovelViewController
            let movelSelecionado:NSManagedObject = moveis[self.tableView.indexPathForSelectedRow!.item]
            t.movelVindoDaTable = movelSelecionado
        }
    }
    
}
