//
//  MonthlyTableViewController.swift
//  controlSpending
//
//  Created by Sherry Chan on 4/14/18.
//  Copyright © 2018 Sherry Chan. All rights reserved.
//

import UIKit
import CoreData

class MonthlyTableViewController: UITableViewController {
    
    var transList = [Transaction]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    //Number of lists
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    //number of rows in the list
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return transList.count
    }
    /*
    @IBAction func addItem(segue:UIStoryboardSegue){
     if let sourceVC = segue.source as? AddNewTransactionViewController, let filledAmount = sourceVC.amountLabel.text, let filledDesc = sourceVC.descLabel.text{
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else {return}
        let newTrans = NSEntityDescription.entity(forEntityName: "Transaction", in: context)!
        let transaction = NSManagedObject(entity: newTrans, insertInto: context)
        transaction.setValue(filledAmount, forKeyPath: "amount")
        transaction.setValue(filledDesc, forKeyPath: "desc")
        do{
            try context.save()
        } catch let error as NSError{
            print("Couldn't save. \(error), \(error.userInfo)")
        }
     /*let appDelegate = UIApplication.shared.delegate as! AppDelegate
     let context = appDelegate.persistentContainer.viewContext
     let newTrans = NSEntityDescription.entity(forEntityName: "Transaction", in: context)!
     let oneTrans = NSManagedObject(entity: newTrans, insertInto: context)
     oneTrans.setValue(filledAmount, forKeyPath: "amount")
     oneTrans.setValue(filledDesc, forKeyPath: "desc")
     let calendar = Calendar.current
     let month = calendar.component(.month, from: sourceVC.dateLabel.date)
     let year = calendar.component(.year, from:sourceVC.dateLabel.date)
     oneTrans.setValue(month, forKeyPath: "month")
     oneTrans.setValue(year, forKeyPath: "year")
     oneTrans.setValue(sourceVC.dateLabel.date, forKeyPath: "date")
     do{
     try context.save()
     } catch let error as NSError{
     print("Couldn't save. \(error), \(error.userInfo)")
     }*/
     
     
     //tableView.reloadData()
     }
     
     }*/
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "TransactionTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TransactionTableViewCell
        
        do{
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let context = appDelegate?.persistentContainer.viewContext
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Transaction")
            let result = try context?.fetch(fetch as! NSFetchRequest<Transaction>)
            for transaction in result! {
                transList.append(transaction as! Transaction)
            }
        } catch {
            print("Failed")
        }
        let trans = transList[indexPath.row]
        cell.descLabel.text = trans.desc
        /*
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        do {
            let result = try context?.fetch(fetch)
            for data in result as! [NSManagedObject]{
                cell.amountLabel.text = data.value(forKeyPath: "amount") as! String
                cell.descLabel.text = data.value(forKey: "desc") as! String
            }
        } catch {
            print("Failed")
        }*/
        
        // Fetches the appropriate note for the data source layout.
        //let transaction = monthList[0].transactions[indexPath.row]
        
        //cell.descLabel.text = transaction.desc
        //cell.amountLabel.text = String(transaction.amount)
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "addNewTransaction" ){
            let destVC = segue.destination as! UINavigationController
            let targetVC = destVC.topViewController as! AddNewTransactionViewController
        }
    }*/
    

}
