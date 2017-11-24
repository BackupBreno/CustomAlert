//
//  ViewController.swift
//  POC-GenericAlert
//
//  Created by Breno Aquino on 21/11/2017.
//  Copyright © 2017 Breno Aquino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showAlerta(_ sender: Any) {
        
        let alert = AlertView(title: "Hello there!! 👋🏻👋🏻")
        let customView = CustomView()
        alert.addViewAlert(view: customView, height: 100)
        alert.addButton(title: "Fechar", viewController: self, action: #selector(self.printButton))
        alert.addButton(title: "Outro", viewController: self, action: #selector(self.printButton))
        alert.addButton(title: "Mais", viewController: self, action: #selector(self.printButton))
        alert.show(animated: true)
    }
    
    @objc func printButton() {
        
        print("Alou")
    }
}

