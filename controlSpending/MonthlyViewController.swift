//
//  MonthlyViewController.swift
//  controlSpending
//
//  Created by Sherry Chan on 4/27/18.
//  Copyright © 2018 Sherry Chan. All rights reserved.
//

import UIKit

class MonthlyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let manageObjectContext = (UIApplication.shared.delegate as!
        AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var myTable: UITableView!
    
    var transactionList: [Transaction] = []
    var arrayForSelected: [Transaction] = []
    var sum = "Total: "
    
    //Gets the sum for the total on the top
    func gettingSum() -> Void {
        do{
            transactionList = try manageObjectContext.fetch(Transaction.fetchRequest())
            var tot:Double = 0.00
            for i in 0 ..< transactionList.count {
                tot += transactionList[i].amount as! Double
            }
            sum = "Total: $" + (NSString(format: "%.2f", tot as CVarArg) as String)
        }
        catch{
            print("Fetching Failed")
        }
    }
    
    //Control the navigation label
    func addUp() -> Void {
        if let navigationBar = self.navigationController?.navigationBar {
            let totalFrame = CGRect(x: 10, y: 0, width: navigationBar.frame.width/2, height: navigationBar.frame.height)
            let totalLabel = UILabel(frame: totalFrame)
            totalLabel.text = sum
            totalLabel.font = UIFont(name: "Bodoni 72", size: 20)
            totalLabel.tag = 1
            navigationBar.addSubview(totalLabel)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (transactionList.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
        cell.textLabel?.text = transactionList[indexPath.row].desc
        cell.textLabel?.font = UIFont(name: "Bodoni 72", size: 17)
        cell.detailTextLabel?.text = "$" + (NSString(format: "%.2f", (transactionList[indexPath.row].amount as! Double) as CVarArg) as String)
        cell.detailTextLabel?.font = UIFont(name: "Bodoni 72", size: 17)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        arrayForSelected = [transactionList[indexPath.row]]
        performSegue(withIdentifier: "addSegue", sender: nil)
        myTable.deselectRow(at: indexPath, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gettingSum()
        addUp()
        myTable.dataSource = self
        print(transactionList as Any)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
        if ![transactionList[indexPath.row]].isEmpty{
            arrayForSelected = [transactionList[indexPath.row]]
            transactionList.remove(at: indexPath.row)
            let deleteArray = arrayForSelected[0]
            manageObjectContext.delete(deleteArray)
            arrayForSelected.removeAll()
            do {
                try manageObjectContext.save()
                myTable.reloadData()
                gettingSum()
                self.navigationController?.navigationBar.viewWithTag(1)?.removeFromSuperview()
                addUp()

            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        }
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! UINavigationController
        let targetVC = destVC.topViewController as! AddNewTransactionViewController
        targetVC.transactionList = arrayForSelected
        arrayForSelected.removeAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gettingSum()
        myTable.reloadData()
        addUp()
        self.navigationController?.navigationBar.viewWithTag(1)?.removeFromSuperview()

    }
    
}

