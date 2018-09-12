//
//  PasswordViewController.swift
//  controlSpending
//
//  Created by Sherry Chan on 4/26/18.
//  Copyright © 2018 Sherry Chan. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {

    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var pass2TF: UITextField!
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
    
    @IBAction func saveData(_ sender: Any) {
        if (passTextField.text == pass2TF.text){
            errorTF.isHidden = true
            UserDefaults.standard.set(passTextField.text, forKey: "password")
            dismiss(animated: true, completion: nil)
        }
        else{
            errorTF.isHidden = false
            errorTF.text = "Error with password, try again."
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
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
