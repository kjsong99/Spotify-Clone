//
//  Extension.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/26.
//

import Foundation
import UIKit


extension UITableViewCell{
    static var identifier : String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    static var identifier : String {
        return String(describing: self)
    }
}


extension UITableView{
    func dequeueCell<T: UITableViewCell>(type: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            preconditionFailure()
        }
        return cell
    }
}

extension UICollectionView{
    func dequeueCell<T: UICollectionViewCell>(type: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            preconditionFailure()
        }
        return cell
    }
}

extension UIViewController{
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func hideKeyboardWhenTappedAround(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}

extension Int {
    var hour: Int {
        self / 3600
    }
    var minute: Int {
        (self % 3600) / 60
    }
    var seconds: Int {
        (self % 60)
    }
}

extension UINavigationController{
    func pushViewControllerFromLeft(viewControlller : UIViewController){
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = .moveIn
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        view.window?.layer.add(transition, forKey: kCATransition)
        self.pushViewController(viewControlller, animated: false)
        self.setNavigationBarHidden(false, animated: false)
        
    }
    
    func popViewControllerToLeft(){
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = .moveIn
        transition.subtype = .fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        view.window?.layer.add(transition, forKey: kCATransition)
        
        popViewController(animated: false)
        self.setNavigationBarHidden(true, animated: false)
        
    }
}

extension UITextField {
    func setPlaceholder(color: UIColor) {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
}

extension UIView{
    func getRoundedCorner(){
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
    }
}

extension UIImageView{
    func getCircleImage(){
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderWidth = 1
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.clear.cgColor
        self.contentMode = .scaleToFill
    }
    
    func getShalpImage(){
        self.layer.cornerRadius = 0
    }
    
}

extension UIView{
    func getGradient(color : UIColor){
        self.backgroundColor = color
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = self.bounds
        
        gradientMaskLayer.colors = [ UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientMaskLayer.locations = [0, 0.5]
        
        self.layer.mask = gradientMaskLayer
    }
}

