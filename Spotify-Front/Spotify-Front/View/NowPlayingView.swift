//
//  nowPlayingView.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/11.
//

import UIKit
import Foundation
import SnapKit

enum status {
    case end
    case pause
    case play
}

class NowPlayingView: UIView {
    var max: Float = 0.0
    var interval: Float = 0.0
    var time: Float = 0.0
    var timer: Timer?
    var nowPlaying: status = status.end


    @objc func setProgress() {
        time += interval
        progressView.setProgress(time, animated: false)
        if time >= 1.0 {
            end()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    let albumImageView : UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "CircularStd-Book", size: 14)
        label.textColor = .white
        label.textAlignment = .left

        return label
    }()
    
    let singerLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "CircularStd-Book", size: 13)
        label.textColor = hexStringToUIColor(hex: "#BDBDBD")
        label.textAlignment = .left
        return label
    }()
    
    let deviceBtn : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "computer"), for: .normal)
        return button
    }()
    
    let playBtn : UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setImage(UIImage(named: "play"), for: .normal)
        button.addTarget(self, action: #selector(playBtnTapped), for: .touchDown)
        return button
    }()
    
    let progressView : UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = hexStringToUIColor(hex: "#5B5B5B")
        view.progressTintColor = .white
        view.progressViewStyle = .default
        
        return view
    }()
    
    @objc func playBtnTapped(){
        if nowPlaying == status.play {
            //일시정지 로직
            pause()
           
        }else if nowPlaying == status.end{
            //재생 로직
            time = 0.0
            play()
            
        }else if nowPlaying == status.pause{
            //재생 로직 (일시정지 상태에서)
            play()
        }
    }
    func setLayout(){
        self.addSubview(albumImageView)
        self.addSubview(nameLabel)
        self.addSubview(singerLabel)
        self.addSubview(deviceBtn)
        self.addSubview(playBtn)
        self.addSubview(progressView)
        
        albumImageView.snp.makeConstraints{ image in
            image.centerY.equalToSuperview()
            image.left.equalToSuperview().offset(convertWidth(originValue: 8.0))
            image.width.equalTo(convertWidth(originValue: 39.0))
            image.height.equalTo(convertHeight(originValue: 39.0))
        }
        
        nameLabel.snp.makeConstraints{ label in
            label.left.equalTo(albumImageView.snp.right).offset(convertWidth(originValue: 11.0))
            label.top.equalToSuperview().offset(convertHeight(originValue: 8.0))
            label.width.equalTo(convertWidth(originValue: 88.0))
            label.height.equalTo(convertHeight(originValue: 12.0))
            
        }
        
        singerLabel.snp.makeConstraints{ label in
            label.left.equalTo(albumImageView.snp.right).offset(convertWidth(originValue: 11.0))
            label.top.equalTo(nameLabel.snp.bottom).offset(convertHeight(originValue: 8.0))
            label.width.equalTo(convertWidth(originValue: 50.0))
            label.height.equalTo(convertHeight(originValue: 11.0))
        }
        
        playBtn.snp.makeConstraints{ btn in
            btn.right.equalToSuperview().offset(-1 * convertWidth(originValue: 23.0))
            btn.centerY.equalToSuperview()
            btn.width.equalTo(convertWidth(originValue: 22.0))
            btn.height.equalTo(convertHeight(originValue: 20.0))
        }
        
        deviceBtn.snp.makeConstraints{ btn in
            btn.right.equalTo(playBtn.snp.left).offset(-1 * convertWidth(originValue: 25.0))
            btn.centerY.equalToSuperview()
            btn.width.equalTo(convertWidth(originValue: 22.0))
            btn.height.equalTo(convertHeight(originValue: 20.0))
        }
        
        progressView.snp.makeConstraints{ view in
            view.width.equalToSuperview()
            view.height.equalTo(convertHeight(originValue: 1.0))
            view.bottom.equalToSuperview()
        }
        
    }
    
    func pause(){
        timer?.invalidate()
        playBtn.setImage(UIImage(named: "play"), for: .normal)
        nowPlaying = status.pause
    }
    
    func play(){
        nowPlaying = status.play
        playBtn.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(setProgress), userInfo: nil, repeats: true)
    }
    
    func end(){
        timer?.invalidate()
        playBtn.setImage(UIImage(named: "play"), for: .normal)
        nowPlaying = status.end
    }
    
    func configure(music : Music){
//        nameLabel.text = music.name
//        singerLabel.text = music.artist.name
//        albumImageView.image = UIImage(named: music.imageName)
//        interval = 1.0 / Float(music.length)
//        max = Float(music.length)

    }
    
    
}

extension NowPlayingView {
    func setConstraints(){
        self.snp.makeConstraints{ view in
            view.left.right.width.equalToSuperview()
            view.height.equalTo(convertHeight(originValue: 56.0))
            view.bottom.equalToSuperview()
        }
    }
}
