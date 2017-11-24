//
//  CustomView.swift
//  POC-GenericAlert
//
//  Created by Breno Aquino on 21/11/2017.
//  Copyright © 2017 Breno Aquino. All rights reserved.
//

import UIKit
import Reusable

class CustomView: UIView, NibOwnerLoadable {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadNibContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
