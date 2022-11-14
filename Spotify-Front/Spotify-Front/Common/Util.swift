//
//  Util.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/07.
//

import Foundation
import UIKit

var width : CGFloat = UIScreen.main.bounds.width
var height : CGFloat = UIScreen.main.bounds.height

var isPlayingViewVisible = false

let playingView = {
    let view = nowPlayingView()
    view.backgroundColor = hexStringToUIColor(hex: "#232323")
    view.configure(music: song)
    view.isHidden = true
    return view
    
}()

func convertWidth(originValue : CGFloat) -> CGFloat{
    return originValue / 375 * width
    
}

func convertHeight(originValue : CGFloat) -> CGFloat{
    return originValue / 812 * height
}


func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
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
