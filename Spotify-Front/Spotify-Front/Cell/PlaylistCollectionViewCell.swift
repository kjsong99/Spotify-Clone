//
//  PlaylistCollectionViewCell.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/08.
//

import UIKit
import SnapKit

class PlaylistCollectionViewCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    let nameView: UIView = {
       let view = UIView()
        view.backgroundColor = hexStringToUIColor(hex: "#252525")
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont(name: "CircularStd-Bold", size: 12)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setLayout(){
        contentView.addSubview(imageView)
        nameView.addSubview(nameLabel)
        contentView.addSubview(nameView)
        
        imageView.snp.makeConstraints{ make in
            make.width.equalTo(convertWidth(originValue: 56.0))
            make.height.equalTo(convertHeight(originValue: 56.0))
            make.left.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        nameView.snp.makeConstraints{ make in
            make.width.equalTo(convertWidth(originValue: 111.0))
            make.height.equalTo(convertHeight(originValue: 56.0))
            make.right.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(convertHeight(originValue: 8.0))
            make.left.equalToSuperview().offset(convertWidth(originValue: 8.0))
            make.right.equalToSuperview().offset(-1 * convertWidth(originValue: 8.0))
            make.bottom.equalToSuperview().offset(-1 * convertHeight(originValue: 8.0))
            make.width.equalTo(convertWidth(originValue: 87.0))
            make.height.equalTo(convertHeight(originValue: 87.0))
        }
        
    }
    
    func configure(playlist: Playlist){
        imageView.image = UIImage(named: playlist.imageName)
        nameLabel.text = playlist.name
    }
    
}
