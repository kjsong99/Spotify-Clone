//
//  EpisodeCollectionViewCell.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/10.
//

import UIKit
import SnapKit

class EpisodeCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Placeholder")
        return imageView
    }()
    
    let labelView : UIView = {
       let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let btnView : UIView = {
       let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let nameLabel : UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "CircularStd-Bold", size: 13)
        textView.textAlignment = .left
        textView.clipsToBounds = true
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.textContainerInset = .zero
        textView.textColor = .white
        return textView
    }()
    
    let contentLabel : UITextView = {
        let textView = UITextView()
        textView.textColor = hexStringToUIColor(hex: "#A7A7A7")
        textView.font = UIFont(name: "CircularStd-Book", size: 13)
        textView.textAlignment = .left
        textView.textContainerInset = .zero
        textView.backgroundColor = .clear

        
        textView.clipsToBounds = true
        textView.isScrollEnabled = false

        return textView
    }()
    
    let infoLabel : UILabel = {
        let label = UILabel()
        label.textColor = hexStringToUIColor(hex: "#A7A7A7")
        label.font = UIFont(name: "CircularStd-Book", size: 11)
        label.textAlignment = .left
        return label
    }()
    
    let playButton : UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(named: "circle play"), for: .normal)
        return btn
    }()
    
    let plusButton : UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(named: "plus"), for: .normal)
        btn.tintColor = hexStringToUIColor(hex: "#A7A7A7")
        return btn
    }()
    
    func setLayout(){
        contentView.addSubview(imageView)
        contentView.addSubview(labelView)
        contentView.addSubview(btnView)
        
        labelView.addSubview(nameLabel)
        labelView.addSubview(contentLabel)
        
        btnView.addSubview(infoLabel)
        btnView.addSubview(plusButton)
        
        contentView.addSubview(playButton)
        
        imageView.snp.makeConstraints{ make in
            make.width.equalTo(convertWidth(originValue: 104.0))
            make.height.equalTo(convertHeight(originValue: 104.0))
            make.left.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        labelView.snp.makeConstraints{ make in
            make.width.equalTo(convertWidth(originValue: 188.0))
            make.height.equalTo(convertHeight(originValue: 69.0))
            make.top.equalToSuperview()
            make.left.equalTo(imageView.snp.right).offset(convertWidth(originValue: 17.0))
        }
        
        nameLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(convertHeight(originValue: 35.0))
        }
        
        contentLabel.snp.makeConstraints{ make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(convertHeight(originValue: 34.0))
        }
        
        btnView.snp.makeConstraints{ make in
            make.width.equalTo(convertWidth(originValue: 112.0))
            make.height.equalTo(convertHeight(originValue: 22.0))
            make.bottom.equalToSuperview()
            make.left.equalTo(imageView.snp.right).offset(convertWidth(originValue: 17.0))
        }
        
        plusButton.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(convertWidth(originValue: 22.0))
            make.height.equalTo(convertHeight(originValue: 22.0))
        }
        
        infoLabel.snp.makeConstraints{ make in
            make.width.equalTo(convertWidth(originValue: 82.0))
            make.height.equalTo(convertHeight(originValue: 14.0))
            make.centerY.equalToSuperview()
            make.left.equalTo(plusButton.snp.right).offset(convertWidth(originValue: 8.0))
        }
        
        playButton.snp.makeConstraints{ make in
            make.width.equalTo(convertWidth(originValue: 24.0))
            make.height.equalTo(convertHeight(originValue: 24.0))
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        
    }
    
    func configure(episode : Episode){
        imageView.image = UIImage(named: episode.imageName)
        nameLabel.text = episode.name
        contentLabel.text = episode.content
        infoLabel.text = episode.day + " • " + episode.length
        
    }
    
}
