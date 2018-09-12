//
//  AddNewTransactionViewController.swift
//  controlSpending
//
//  Created by Sherry Chan on 4/14/18.
//  Copyright © 2018 Sherry Chan. All rights reserved.
//

import UIKit
import CoreData
import MessageUI
import MapKit
import CoreLocation

class AddNewTransactionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate, CLLocationManagerDelegate {
    
    let manageObjectContext = (UIApplication.shared.delegate as!
        AppDelegate).persistentContainer.viewContext
    var transactionList: [Transaction] = []
    var myIndex = -1
    @IBOutlet weak var descLabel: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var amountLabel: UITextField!{
        didSet{
            amountLabel.keyboardType = UIKeyboardType.decimalPad
        }
    }
    @IBOutlet weak var dateLabel: UIDatePicker!
    
    
    @IBAction func useCamera(_ sender: AnyObject) {
        // Add your code here
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            print("Camera unavailable")
        }
    }
    
    @IBAction func useImageLibrary(_ sender: AnyObject) {
        // Add your code here
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        //self.navigationController?.navigationBar.viewWithTag(1)?.isHidden = true
        if !transactionList.isEmpty {
            
            descLabel.text = transactionList[0].desc
            amountLabel.text = String(transactionList[0].amount)
            dateLabel.date = transactionList[0].date!
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        let center = location.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: center, span: span)
        
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveItem(sender: UIBarButtonItem) {
        if !transactionList.isEmpty {
            let first = transactionList[0]
            first.desc = descLabel.text
            first.amount = Double(amountLabel.text!) as! Double
            first.date = dateLabel.date
            let calendar = Calendar.current
            let month = calendar.component(.month, from: dateLabel.date)
            let year = calendar.component(.year, from: dateLabel.date)
            first.year = Int16(year)
            first.month2 = Int16(month)
            
        }
        else{
            let first = Transaction(context: manageObjectContext)
            first.desc = descLabel.text
            first.amount = Double(amountLabel.text!) as! Double
            first.date = dateLabel.date
            let calendar = Calendar.current
            let month = calendar.component(.month, from: dateLabel.date)
            let year = calendar.component(.year, from: dateLabel.date)
            first.year = Int16(year)
            first.month2 = Int16(month)
        }
        do{
            try manageObjectContext.save()
            transactionList.removeAll()
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        } catch let error as NSError{
            print("Couldn't save. \(error), \(error.userInfo)")
        }
    }
    @IBAction func recommending(sender: UIButton) {
        myIndex = sender.tag
        let mailComposeViewController = configureMailController()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        }else{
            showMailError()
        }
    }
    
    func configureMailController()->MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self as! MFMailComposeViewControllerDelegate
        
        mailComposerVC.setToRecipients([""])
        mailComposerVC.setSubject("Pay me back")
        mailComposerVC.setMessageBody("Pay me back for" + descLabel.text!, isHTML: false)
        
        return mailComposerVC
    }
    
    func showMailError(){
        let sendMail = UIAlertController(title: "Can't send email!", message: "Your device cannot send this email", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
        sendMail.addAction(dismiss)
        self.present(sendMail, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.image = image
            dismiss(animated: true, completion: nil)
        }
    }

}
