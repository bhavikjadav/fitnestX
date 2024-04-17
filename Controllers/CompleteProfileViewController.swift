//
//  CompleteProfileViewController.swift
//  FitnestX
//
//  Created by Bhavik Jadav on 17/04/24.
//

import UIKit

class CompleteProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let genderPicker = UIPickerView()
    let datePicker = UIDatePicker()
    let genders = ["Male", "Female", "Other"]
    
    @IBOutlet weak var genderTextField: FXCustomTextField!
    @IBOutlet weak var dobTextField: FXCustomTextField!
    @IBOutlet weak var weightTextField: FXCustomTextField!
    @IBOutlet weak var heightTextField: FXCustomTextField!
    @IBOutlet weak var nextBtn: FXPrimaryButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genderPicker.delegate = self
        genderPicker.dataSource = self
        
        loadBasicDesigns()
        setupDatePicker()
    }
    
    private func loadBasicDesigns() {
        genderTextField.setLeftImage(UIImage(named: "gender.png")!)
        genderTextField.setRightImage(UIImage(named: "arrow.png")!)
        dobTextField.setLeftImage(UIImage(named: "calendar.png")!)
        weightTextField.setLeftImage(UIImage(named: "weightScale.png")!)
        heightTextField.setLeftImage(UIImage(named: "swap.png")!)
        
        // Connect the UIPickerView to the UITextField
        genderTextField.inputView = genderPicker
    }
    
    //MARK: - UIPickerView Delegates & Datasource Methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = genders[row]
    }
    
    //MARK: - Setup the UIDatePicker
    func setupDatePicker() {
        // Configure the datePicker mode.
        datePicker.datePickerMode = .date
        
        // Use `.wheels` for older style, or `.inline`/`.compact` for iOS 14+.
        if #available(iOS 13.4, *) {
            if #available(iOS 14.0, *) {
                datePicker.preferredDatePickerStyle = .inline
            } else {
                // Fallback on earlier versions
                datePicker.preferredDatePickerStyle = .wheels
            }
        }
        
        // Setting datePicker as inputView to the textField.
        dobTextField.inputView = datePicker
        
        // Adding a toolbar with a Done button.
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissDatePicker))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        dobTextField.inputAccessoryView = toolBar
    }

    @objc func dismissDatePicker() {
        // When the user selects Done, update the text field with the date.
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        dobTextField.text = formatter.string(from: datePicker.date)
            
        // Dismiss the datePicker.
        view.endEditing(true)
    }

}
