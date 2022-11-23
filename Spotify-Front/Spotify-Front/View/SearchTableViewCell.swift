//
//  SearchHistoryTableViewCell.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/12.
//

import UIKit
import SnapKit
import Kingfisher
class SearchTableViewCell: UITableViewCell {
    
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
        self.tintColor = hexStringToUIColor(hex: "#A7A7A7")
        self.backgroundColor = .clear
        
        contentView.addSubview(image)
        contentView.addSubview(labelView)
        labelView.addSubview(nameLabel)
        labelView.addSubview(infoLabel)
        //        contentView.addSubview(mark)
        contentView.addSubview(goButton)
        contentView.addSubview(menuButton)
        
        image.snp.makeConstraints{ image in
            image.width.equalTo(convertWidth(originValue: 48.0))
            image.height.equalTo(convertHeight(originValue: 48.0))
            image.centerY.equalToSuperview()
            image.left.equalToSuperview().offset(convertWidth(originValue: 16.0))
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
        
        goButton.snp.makeConstraints{ btn in
            btn.centerY.equalToSuperview()
            btn.right.equalToSuperview().offset(-1 * convertWidth(originValue: 16.0))
            btn.width.equalTo(convertWidth(originValue: 25.0))
            btn.height.equalTo(convertHeight(originValue: 22.0))
        }
        
        menuButton.snp.makeConstraints{ btn in
            btn.centerY.equalToSuperview()
            btn.right.equalToSuperview().offset(-1 * convertWidth(originValue: 16.0))
            btn.width.equalTo(convertWidth(originValue: 25.0))
            btn.height.equalTo(convertHeight(originValue: 22.0))
        }
        
        
        
    }
    let labelView : UIView = {
        let view = UIView()
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
    
    let goButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow"), for: .normal)
        return button
    }()
    
    let menuButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "dot3"), for: .normal)
        return button
    }()
    
    func configure(search: Search){
        nameLabel.text = search.name
        guard let url = URL(string: "http://localhost:8080/" + search.image_path) else {
            return
        }


        
        switch search.category {
        case "artist":
            infoLabel.text = search.category
            downloadImage(with: "http://localhost:8080/" + search.image_path){ result in
                switch result {
                case let .success(result):
                    self.image.image = result
                    self.image.getCircleImage()

                case let .failure(error):
                    print(error.localizedDescription)
                }
            }

            goButton.isHidden = false
            menuButton.isHidden = true
            
        case "music":
            goButton.isHidden = true
            menuButton.isHidden = false
            infoLabel.text = search.category
            image.kf.setImage(with: url, placeholder: UIImage(systemName: "circle.fill"))
            
        case "album":
            goButton.isHidden = false
            menuButton.isHidden = true
            infoLabel.text = search.category

            image.kf.setImage(with: url, placeholder: UIImage(systemName: "circle.fill"))
        default:
            print("error")
            
        }
        
        
    }
    
    
    
}
