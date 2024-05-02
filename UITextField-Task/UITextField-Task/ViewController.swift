//
//  ViewController.swift
//  UITextField-Task
//
//  Created by Sparkout on 02/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var dobField: UITextField!
    
    
    @IBOutlet weak var mobileField: UITextField!
    
    @IBOutlet weak var bioField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        dobField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
    }
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dobField.text = dateFormatter.string(from: datePicker.date)
    }
    
    @IBAction func btnTapped(_ sender: UIButton) {
        if validateForm(){
            navigateToNextScreen()
        
    }
    
    func validateForm() -> Bool{
        var error = ""
        
        let username = usernameField.text ?? ""
        let email = emailField.text ?? ""
        let dob = dobField.text ?? ""
        let mobile = mobileField.text ?? ""
        let bio = bioField.text ?? ""
        
        let usernameRegex = "^[a-zA-Z]{5,}$"
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let mobileRegex = "^[0-9]{10}$"
        
        let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let mobilePredicate = NSPredicate(format: "SELF MATCHES %@", mobileRegex)
        
        if !usernamePredicate.evaluate(with: username) {
            error += "Username must contain only letters and be at least 5 characters long.\n"
        }
        if !emailPredicate.evaluate(with: email) {
            error += "Please enter a valid email address.\n"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        if let date = dateFormatter.date(from: dob), date > Date() {
            error += "Date of Birth cannot be in the future.\n"
        }
        if !mobilePredicate.evaluate(with: mobile) {
            error += "Mobile number must contain only numbers and be 10 digits long.\n"
        }
        if (bio.count) < 100 {
            error += "Bio must be at least 100 characters long.\n"
            }
            
            if error != "" {
                showAlert(message: error)
                return false
            }
            return true
        }
        
        func showAlert(message: String){
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        
        func navigateToNextScreen(){
            performSegue(withIdentifier: "NextViewController", sender: nil)
        }
    }
    
}
