//
//  AlertDelegate.swift
//  POC-GenericAlert
//
//  Created by Breno Aquino on 21/11/2017.
//  Copyright © 2017 Breno Aquino. All rights reserved.
//

import UIKit

protocol Alert {
    
    func show(animated: Bool)
    
    func dismiss(animated: Bool)
    
    var backgroundView: UIView {get}
    
    var dialogView: UIView {get set}
    
    var modal: Bool {get set}
}

extension Alert where Self: UIView {
    
    func show(animated: Bool) {
        
        if !self.modal {
            
            self.backgroundView.alpha = 0
            
            self.dialogView.center = self.center
            
            self.dialogView.alpha = 0
            
            UIApplication.shared.delegate?.window??.rootViewController?.view.addSubview(self)
            
            if animated {
                
                UIView.animate(withDuration: 0.2, animations: {
                    
                    self.backgroundView.alpha = 0.5
                })
                
                UIView.animate(withDuration: 0.33, animations: {
                    
                    self.dialogView.alpha = 0.95
                    
                }, completion: { (completed) in
                    
                })
                
            } else {
                
                self.backgroundView.alpha = 0.66
                
                self.dialogView.center  = self.center
            }
            
        } else {
            
            self.backgroundView.alpha = 0
            
            self.dialogView.center = CGPoint(x: self.center.x, y: self.frame.height + self.dialogView.frame.height/2)
            
            UIApplication.shared.delegate?.window??.rootViewController?.view.addSubview(self)
            
            if animated {
                
                UIView.animate(withDuration: 0.33, animations: {
                    
                    self.backgroundView.alpha = 0.66
                })
                
                UIView.animate(withDuration: 0.33, animations: {
                    
                    self.dialogView.center  = self.center
                    
                }, completion: { (completed) in
                    
                })
                
            } else {
                
                self.backgroundView.alpha = 0.66
                
                self.dialogView.center  = self.center
            }
        }
    }
    
    func dismiss(animated: Bool){
        
        if !self.modal {
        
            if animated {
                
                UIView.animate(withDuration: 0.2, animations: {
                    
                    self.backgroundView.alpha = 0
                })
                
                UIView.animate(withDuration: 0.33, animations: {
                    
                    self.dialogView.alpha = 0
                }, completion: { (completed) in
                    
                    self.removeFromSuperview()
                })
                
            } else {
                
                self.removeFromSuperview()
            }
            
        } else {
        
            if animated {
                
                UIView.animate(withDuration: 0.33, animations: {
                    
                    self.backgroundView.alpha = 0
                    
                }, completion: { (completed) in
                    
                })
                
                UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
                    
                    self.dialogView.center = CGPoint(x: self.center.x, y: self.frame.height + self.dialogView.frame.height/2)
                    
                }, completion: { (completed) in
                    
                    self.removeFromSuperview()
                })
                
            } else {
                
                self.removeFromSuperview()
            }
        }
    }
}
