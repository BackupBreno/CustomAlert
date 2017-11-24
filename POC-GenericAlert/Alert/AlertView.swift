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
    
    var height: CGFloat = 0
    
    var width: CGFloat = 0
    
    var lastFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    var numButtons: Int = 0
    var buttons: [UIButton] = []
    var stackViewButtonAlert: UIStackView!
    var stackViewButtonAlertHeight: CGFloat = 30
    
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
        
        dialogView.frame.origin = CGPoint(x: 32, y: frame.height)
        dialogView.frame.size = CGSize(width: frame.width-64, height: self.height)
        dialogView.backgroundColor = UIColor.white
        dialogView.layer.cornerRadius = 6
        dialogView.clipsToBounds = true
        addSubview(dialogView)
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
    
//    func getNextButtonFrame() -> CGRect
    
    // MARK: Add Elemets
    func reloadStackView() {
        
        self.stackViewButtonAlert.frame = CGRect(x: 0, y: self.lastFrame.origin.y + self.lastFrame.height + 8, width: self.width, height: self.stackViewButtonAlertHeight)
    }
    
    func addViewAlert(view: UIView, height: Float) {
        
        let separator = UIView()
        separator.frame = self.getNextFrame(x: 0, width: self.width, height: 1)
        separator.backgroundColor = UIColor.groupTableViewBackground
        self.dialogViewAddSubView(separator)
        
        view.frame = self.getNextFrame(x: 8, width: self.width - 16, height: CGFloat(height))
        self.dialogViewAddSubView(view)
        
        self.reload()
    }
    
    func addButton(title: String, alertMode: Bool = true, viewController: UIViewController, action: Selector) {
        
        self.numButtons += 1
        
        if let _ = self.stackViewButtonAlert {
            
            
        } else {
            
            let separator = UIView()
            separator.frame = self.getNextFrame(x: 0, width: self.width, height: 1)
            separator.backgroundColor = UIColor.groupTableViewBackground
            self.dialogViewAddSubView(separator)
            
            self.stackViewButtonAlert = UIStackView()
            self.stackViewButtonAlert.axis = .horizontal
            self.stackViewButtonAlert.distribution = .equalSpacing
            self.stackViewButtonAlert.alignment = .fill
            
            var frame = self.getNextFrame(x: 0, width: self.width, height: 30)
            frame.origin.y -= 8
            
            self.stackViewButtonAlert.frame = frame
            self.stackViewButtonAlert.backgroundColor = .blue
            self.dialogViewAddSubView(self.stackViewButtonAlert)
            
            self.stackViewButtonAlert.frame.size.height += 8
            
            self.reload()
        }
        
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .center
        button.addTarget(viewController, action: action, for: .touchUpInside)
        
        self.buttons.append(button)
        
        for buttonUni in self.buttons {
            
            buttonUni.widthAnchor.constraint(equalToConstant: self.width / CGFloat(self.numButtons) - 1.5).isActive = true
        }
        
        self.stackViewButtonAlert.addArrangedSubview(button)
        
        self.stackViewButtonAlert.layoutIfNeeded()
        
        self.layoutIfNeeded()
    }
}
