//
//  SearchHistoryTableViewCell.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/12.
//

import UIKit
import SnapKit
class SearchHistoryTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    func setLayout(){
        self.backgroundColor = .black
        
        contentView.addSubview(image)
        contentView.addSubview(labelView)
        labelView.addSubview(nameLabel)
        labelView.addSubview(infoLabel)
        //        contentView.addSubview(mark)
        contentView.addSubview(deleteBtn)
        
        image.snp.makeConstraints{ image in
            image.width.equalTo(convertWidth(originValue: 48.0))
            image.height.equalTo(convertHeight(originValue: 48.0))
            image.centerY.equalToSuperview()
            image.left.equalToSuperview()
        }
        
        labelView.snp.makeConstraints{ view in
            view.height.equalTo(convertHeight(originValue: 37.0))
            view.width.lessThanOrEqualTo(convertWidth(originValue: 240.0))
            view.centerY.equalToSuperview()
            view.left.equalTo(image.snp.right).offset(convertWidth(originValue: 12.0))
        }
        
        
        
        nameLabel.snp.makeConstraints{ label in
            label.left.equalToSuperview()
            label.top.equalToSuperview().offset(convertHeight(originValue: 5.5))
            label.width.lessThanOrEqualToSuperview()
            label.height.equalTo(convertHeight(originValue: 20.0))
        }
        
        infoLabel.snp.makeConstraints{ label in
            label.width.lessThanOrEqualToSuperview()
            label.height.equalTo(convertHeight(originValue: 15.0))
            label.left.equalToSuperview()
            label.top.equalTo(nameLabel.snp.bottom).offset(convertWidth(originValue: 2.0))
        }
        
        deleteBtn.snp.makeConstraints{ btn in
            btn.centerY.equalToSuperview()
            btn.right.equalToSuperview().offset(-1 * convertWidth(originValue: 14.0))
            //            btn.width.equalTo(convertWidth(originValue: 12.0))
            //            btn.height.equalTo(convertHeight(originValue: 12.0))
        }
    }
    let labelView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let image = {
        let view = UIImageView()
        return view
    }()
    
    let nameLabel = {
        let label = UILabel()
        label.font = UIFont(name: "CircularStd-Book", size: 16)
        label.textColor = .white
        return label
    }()
    
    let infoLabel = {
        let label = UILabel()
        label.font = UIFont(name: "CircularStd-Book", size: 12)
        label.textColor = hexStringToUIColor(hex: "#A7A7A7")
        return label
    }()
    
    let mark = {
        let view = UIImageView()
        return view
    }()
    
    let deleteBtn = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16,weight: .bold)) , for: .normal)
        
        button.tintColor = hexStringToUIColor(hex: "#A7A7A7")
        return button
    }()
    
    func configure(search: Search){
        image.image = UIImage(named: search.imageName)
        nameLabel.text = search.name
        
        switch search.category {
            
        case .artist:
            infoLabel.text = search.category.rawValue
        case .song:
            infoLabel.text = search.category.rawValue + " • " + search.singer!
        case .album:
            infoLabel.text = search.category.rawValue + " • " + search.singer!
        }
        
        
    }
    
    
    
}
