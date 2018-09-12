//
//  SettingsViewController.swift
//  controlSpending
//
//  Created by Sherry Chan on 4/14/18.
//  Copyright © 2018 Sherry Chan. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var setTF: UITextField!
    
    @IBOutlet weak var onButton: UIButton!
    @IBOutlet weak var offButton: UIButton!
    
    @IBAction func turnOff(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "password")
        setTF.text = "Password is currently NOT SET"
        offButton.isHidden = true
        onButton.isHidden = false
        UserDefaults.standard.synchronize()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.removeObject(forKey: "password")
        setTF.text = "Password is currently NOT SET"
        offButton.isHidden = true
        onButton.isHidden = false
        UserDefaults.standard.synchronize()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        if let _ = UserDefaults.standard.string(forKey: "password"){
            setTF.text = "Password is currently SET"
            onButton.isHidden = true
            offButton.isHidden = false
        }else{
            setTF.text = "Password is currently NOT SET"
            offButton.isHidden = true
            onButton.isHidden = false
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func saveNewPassword(segue:UIStoryboardSegue){
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "setPassword" ){
            let destVC = segue.destination as! UINavigationController
            let targetVC = destVC.topViewController as! PasswordViewController
        }
    }

}
