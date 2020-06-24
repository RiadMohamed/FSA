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
    }

    // MARK: - Actions
    // MARK: - FetchButtonTapped
    @IBAction func fetchButtonTapped(_ sender: UIButton) {
        print("Button Tapped")
    }
    

}

