//
//  ViewController.swift
//  FSA
//
//  Created by Riad Mohamed on 6/24/20.
//  Copyright © 2020 Riad Mohamed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets
    
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var localTimeLabel: UILabel!
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countryTextField.delegate = self
        cityTextField.delegate = self
    }

    // MARK: - Actions
        // MARK: - FetchButtonTapped
    @IBAction func fetchButtonTapped(_ sender: UIButton) {
        countryTextField.endEditing(true)
        cityTextField.endEditing(true)
        print("Button Tapped")
        // TODO: call the fetch function
    }

}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        print(textField.text ?? "")
        // TODO: Call the fetch function
        return true
    }
}
