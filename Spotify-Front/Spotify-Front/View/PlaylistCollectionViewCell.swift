//
//  PlaylistCollectionViewCell.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/08.
//

import UIKit

class PlaylistCollectionViewCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    let nameView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = hexStringToUIColor(hex: "#252525")
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont(name: "CircularStd-Bold", size: 12)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
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
        
        
        imageView.widthAnchor.constraint(equalToConstant: convertWidth(originValue: 56.0)).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: convertHeight(originValue: 56.0)).isActive = true
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        nameView.widthAnchor.constraint(equalToConstant: convertWidth(originValue: 111.0)).isActive = true
        nameView.heightAnchor.constraint(equalToConstant: convertHeight(originValue: 56.0)).isActive = true
        nameView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        nameView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: nameView.topAnchor, constant: convertHeight(originValue: 8.0)).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: nameView.leftAnchor, constant: convertWidth(originValue: 8.0)).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: nameView.rightAnchor, constant: -1 * convertWidth(originValue: 8.0)).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: nameView.bottomAnchor, constant: -1 * convertHeight(originValue: 8.0)).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: convertWidth(originValue: 87.0)).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: convertHeight(originValue: 87.0)).isActive = true
    }
    
    func configure(playlist: Playlist){
        imageView.image = UIImage(named: playlist.imageName)
        nameLabel.text = playlist.name
    }
    
}
