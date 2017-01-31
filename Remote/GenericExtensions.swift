//
//  ExtensionUILabel.swift
//  Remote
//
//  Created by Akapo Damilola Francis on 30/01/2017.
//  Copyright © 2017 CottaCush. All rights reserved.
//

import Foundation
import Foundation
import UIKit

extension UITextField {
    
    func clearText() {
        self.text = "";
    }
    
    func addDoneToKeyboard() {
        let keyboardDoneButtonView = UIToolbar();
        keyboardDoneButtonView.sizeToFit();
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target:self, action:nil);
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(UITextField.doneClicked(narButton:)))
        doneButton.tintColor = UIColor.tint
        keyboardDoneButtonView.setItems([flexible, doneButton], animated: true);
        self.inputAccessoryView = keyboardDoneButtonView;
    }
    
    
    func doneClicked(narButton: UIBarButtonItem){
        self.superview?.endEditing(true);
    }
    
    
}

extension UIView {
    public func addShadow(){
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 4.3
        self.layer.cornerRadius = 4.3
    }
}

extension UILabel{
    
    func requiredHeight(){
        let label: UILabel = self;
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = self.font
        label.text = self.text
        label.sizeToFit()
    }
}

extension UIButton{
    func customize(){
        self.layer.cornerRadius = 4.3
    }
}

extension UICollectionViewCell{
    func customize(){
        self.layer.cornerRadius = 4.3
    }
}

extension String{
    func isValidEmail() -> Bool{
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self);
    }
    
    func isValidUrl() -> Bool {
        let urlFormat = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let urlPredicate = NSPredicate(format:"SELF MATCHES %@", urlFormat)
        return urlPredicate.evaluate(with: self);
    }
    
    
    func trim() -> String! {
        return self.trimmingCharacters(in: CharacterSet.whitespaces);
    }

}

extension NSDictionary {
    
    func toJson() -> String?{
        let invalidJson: String? = nil
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
}
