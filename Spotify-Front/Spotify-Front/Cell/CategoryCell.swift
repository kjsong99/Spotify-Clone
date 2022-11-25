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
     
     let label = {
         let label = UILabel()
         label.textAlignment = .center
         label.textColor = .white
         return label
     }()
     
     func setLayout(){
         contentView.backgroundColor = .green
         contentView.addSubview(label)
         label.snp.makeConstraints{ label in
             label.width.centerY.equalToSuperview()
         }
     }
     
     func configure(text : String){
         label.text = text
     }
     
     

     
}
