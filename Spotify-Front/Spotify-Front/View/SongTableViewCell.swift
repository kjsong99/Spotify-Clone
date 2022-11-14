//
//  SongTableViewCell.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/14.
//

import UIKit
import SnapKit
class SongTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(music : Music){
        nameLabel.text = music.name
        artistLabel.text = music.singer
    }
    
    func setLayout(){
        self.backgroundColor = hexStringToUIColor(hex: "#121212")
        contentView.addSubview(nameLabel)
        contentView.addSubview(artistLabel)
        contentView.addSubview(menuBtn)
        
        menuBtn.snp.makeConstraints{ menu in
            menu.width.equalTo(convertWidth(originValue: 17.0))
            menu.height.equalTo(convertHeight(originValue: 3.0))
            menu.right.equalToSuperview().offset(-1 * convertWidth(originValue: 16.0))
            menu.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints{ label in
            label.top.equalToSuperview().offset(convertHeight(originValue: 13.0))
            label.left.equalToSuperview().offset(convertWidth(originValue: 16.0))
            label.width.lessThanOrEqualTo(convertWidth(originValue: 200.0))
        }
        
        artistLabel.snp.makeConstraints{ label in
//            label.bottom.equalToSuperview().offset(-1 * convertHeight(originValue: 13.0))
            label.top.equalTo(nameLabel.snp.bottom).offset(convertHeight(originValue: 8.0))
            label.left.equalToSuperview().offset(convertWidth(originValue: 16.0))
            label.width.lessThanOrEqualTo(convertWidth(originValue: 200.0))
        }
    }
    
    let nameLabel = {
        let label = UILabel()
        label.font = UIFont(name: "CircularStd-Book", size: 16)
        label.textColor = .white
        label.clipsToBounds = true
        return label
    }()
    
    let artistLabel = {
        let label = UILabel()
        label.font = UIFont(name: "CircularStd-Book", size: 13)
        label.textColor = hexStringToUIColor(hex: "#B8B8B8")
        label.clipsToBounds = true

        return label
    }()
    
    let menuBtn = {
        let button = UIButton()
        button.setImage(UIImage(named: "menu"), for: .normal)
        button.tintColor = .white
        return button
    }()

}
