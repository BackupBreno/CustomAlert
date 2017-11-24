//
//  CALayer.swift
//  POC-GenericAlert
//
//  Created by Breno Aquino on 24/11/2017.
//  Copyright © 2017 Breno Aquino. All rights reserved.
//

import UIKit

extension CALayer {

    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
            
        case .bottom:
            border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
            
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
            
        case .right:
            border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
            
        default:
            break
        }
        
        border.backgroundColor = color.cgColor
        
        self.addSublayer(border)
    }
}
