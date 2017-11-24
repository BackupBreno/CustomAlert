//
//  AlertView.swift
//  POC-GenericAlert
//
//  Created by Breno Aquino on 21/11/2017.
//  Copyright © 2017 Breno Aquino. All rights reserved.
//

import UIKit

class AlertView: UIView, Alert {
    
    var backgroundView = UIView()
    
    var dialogView = UIView()
    
    var modal: Bool = false
    
    var height: CGFloat = 0
    
    var width: CGFloat = 0
    
    var lastFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    var buttons: [UIButton] = []
    var separators: [UIView] = []
    
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
    
    func dialogViewAddSubView(_ view: UIView) {
        
        self.dialogView.addSubview(view)
        
        self.height += view.frame.height + 8
    }
    
    func reload() {
        
        dialogView.frame.size = CGSize(width: frame.width - 64, height: self.height + 8)
        
        self.layoutIfNeeded()
    }
    
    convenience init(title: String?) {
        self.init(frame: UIScreen.main.bounds)
        
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AlertView.didTappedOnBackgroundView)))
        
        self.backgroundView.frame = frame
        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.6
        self.addSubview(backgroundView)
        
        self.width = self.frame.width - 64
        
        let titleLabel = UILabel()
        titleLabel.frame = self.getNextFrame(x: 8, width: self.width - 16, height: 30)
        titleLabel.text = title
        titleLabel.textAlignment = .center
        self.dialogViewAddSubView(titleLabel)
        
        self.dialogView.frame.origin = CGPoint(x: 32, y: frame.height)
        self.dialogView.frame.size = CGSize(width: frame.width-64, height: self.height)
        self.dialogView.clipsToBounds = true
        self.dialogView.backgroundColor = .white
        self.dialogView.layer.cornerRadius = 10
        self.dialogView.alpha = 0
        self.dialogView.blurTin
        self.addSubview(self.dialogView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTappedOnBackgroundView(){
        
        dismiss(animated: true)
    }
    
    func getNextFrame(x: Double, width: CGFloat, height: CGFloat) -> CGRect {
        
        self.lastFrame = CGRect(x: CGFloat(x), y: CGFloat(self.lastFrame.origin.y + self.lastFrame.height + 8), width: CGFloat(width), height: CGFloat(height))
        
        return self.lastFrame
    }
    
    func getNextButtonFrame() -> CGRect {
        
        let lastButtonFrame = self.buttons.last!.frame
        
        let nextFrame = CGRect(x: lastButtonFrame.origin.x + lastButtonFrame.width, y: lastButtonFrame.origin.y, width: 3, height: 30)
        
        return nextFrame
    }
    
    // MARK: Add Elemets
    func addViewAlert(view: UIView, height: Float) {
        
        let separator = UIView()
        separator.frame = self.getNextFrame(x: 0, width: self.width, height: 1)
        separator.backgroundColor = UIColor.groupTableViewBackground
        self.dialogViewAddSubView(separator)
        
        view.frame = self.getNextFrame(x: 8, width: self.width - 16, height: CGFloat(height))
        view.layer.cornerRadius = 10
        self.dialogViewAddSubView(view)
        
        self.reload()
    }
    
    func addButton(title: String, alertMode: Bool = true, viewController: UIViewController, action: Selector) {

        if self.buttons.count == 0 {
            
            let separator = UIView()
            separator.frame = self.getNextFrame(x: 0, width: self.width, height: 1)
            separator.backgroundColor = UIColor.groupTableViewBackground
            self.dialogViewAddSubView(separator)
            
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(.blue, for: .normal)
            button.contentVerticalAlignment = .center
            button.contentHorizontalAlignment = .center
            button.addTarget(viewController, action: action, for: .touchUpInside)
            button.frame = self.getNextFrame(x: 0, width: self.width, height: 30)
            button.frame.origin.y -= 8
            
            self.buttons.append(button)
            
            self.dialogViewAddSubView(button)
            
            button.frame.size.height += 16

        } else {
            
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(.blue, for: .normal)
            button.contentVerticalAlignment = .center
            button.contentHorizontalAlignment = .center
            button.addTarget(viewController, action: action, for: .touchUpInside)
            button.frame = self.getNextButtonFrame()
            
            self.buttons.append(button)
            
            let y = self.buttons.first?.frame.origin.y
            let unidade = self.width / CGFloat(self.buttons.count)
            
            for spr in self.separators {
                
                spr.removeFromSuperview()
            }
            
            self.separators = []
            
            for iButton in 0..<self.buttons.count {
                
                self.buttons[iButton].frame = CGRect(x: (CGFloat(iButton) * unidade), y: y!, width: unidade, height: 30)
                self.buttons[iButton].frame.size.height += 16
                
                if iButton > 0 {
                    
                    let separator = UIView()
                    separator.frame = CGRect(x: (CGFloat(iButton) * unidade), y: y!, width: 1, height: 46)
                    separator.backgroundColor = UIColor.groupTableViewBackground
                    
                    self.separators.append(separator)
                    
                    self.dialogView.addSubview(separator)
                }
            }
            
            self.dialogView.addSubview(button)
        }
        
        self.reload()
    }
}
