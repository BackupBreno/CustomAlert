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
//        alert.addButton(title: "Mais", viewController: self, action: #selector(self.printButton))
        alert.show(animated: true)
    }
    
    @IBAction func nativoAlerta(_ sender: Any) {

        let alertController = UIAlertController(title: "\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        let margin:CGFloat = 10.0
        let rect = CGRect(x: margin, y: margin, width: alertController.view.bounds.size.width - margin * 4.0, height: 120)
        let customView = UIView(frame: rect)
        
        customView.backgroundColor = .green
        alertController.view.addSubview(customView)
        
        let somethingAction = UIAlertAction(title: "Something", style: .default, handler: {(alert: UIAlertAction!) in print("something")})
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in print("cancel")})
        
        alertController.addAction(somethingAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    @objc func printButton() {
        
        print("Alou")
    }
}
