//
//  ChangePWViewController.swift
//  controlSpending
//
//  Created by Sherry Chan on 4/26/18.
//  Copyright © 2018 Sherry Chan. All rights reserved.
//

import UIKit

class ChangePWViewController: UIViewController {
    @IBOutlet weak var oldTF: UITextField!
    @IBOutlet weak var newTF: UITextField!
    @IBOutlet weak var new2TF: UITextField!
    @IBOutlet weak var errorTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        errorTF.isHidden = true
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelChange(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmChange(_ sender: Any) {
        if (oldTF.text == UserDefaults.standard.string(forKey: "password")) && (newTF.text == new2TF.text){
            errorTF.isHidden = true
            UserDefaults.standard.set(newTF.text, forKey: "password")
            dismiss(animated: true, completion: nil)
        }
        else{
            errorTF.isHidden = false
            errorTF.text = "Error with password, try again."
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
