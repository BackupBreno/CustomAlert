//
//  BlurView.swift
//  POC-GenericAlert
//
//  Created by Breno Aquino on 24/11/2017.
//  Copyright © 2017 Breno Aquino. All rights reserved.
//

import UIKit

@IBDesignable class BlurView : UIView {
    
    @IBInspectable var blurTintColor: UIColor! {
        set {
            toolbar.barTintColor = blurTintColor
        }
        get {
            return toolbar.barTintColor
        }
    }
    
    lazy var toolbar:UIToolbar = {
        
        self.clipsToBounds = true
        
        let toolbar = UIToolbar(frame: self.bounds)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(toolbar, at: 0)
        let views = ["toolbar": toolbar]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[toolbar]|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[toolbar]|", options: [], metrics: nil, views: views))
        
        return toolbar
    }()
}
