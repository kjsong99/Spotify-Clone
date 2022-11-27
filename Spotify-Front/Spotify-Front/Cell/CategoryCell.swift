//
//  CategoryTableViewCell.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/24.
//

import UIKit
import Foundation
import SnapKit

class CategoryCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override var isSelected: Bool{
        didSet{
            if isSelected{
                setSelectedCell()
            }else{
                setDeselectedCell()
            }
        }
    }
    
    func setSelectedCell(){
        view.backgroundColor = hexStringToUIColor(hex: "#65D46E")
        label.textColor = .black
    }
    
    func setDeselectedCell(){
        view.backgroundColor = hexStringToUIColor(hex: "#313334")
        label.textColor = .white
    }
    let label = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "CircularStd-Book", size: 15)
        
        return label
    }()
    
    let view = {
        let view = UIView()
        view.backgroundColor = hexStringToUIColor(hex: "#313334")
        
        return view
    }()
    
    func setLayout(){
        contentView.addSubview(view)
        view.frame = contentView.frame
        view.addSubview(label)
        view.getRoundedCorner()
        label.snp.makeConstraints{ label in
            label.width.centerY.equalToSuperview()
        }
    }
    
    func configure(text : String){
        label.text = text
    }
    
    
    
    
}


