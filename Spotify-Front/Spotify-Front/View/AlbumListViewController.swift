//
//  AlbumListView.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/14.
//

import UIKit
import SnapKit
import UIImageColors

class AlbumListViewController: UIViewController {
    var songs = [Music]()
    let gradient = CAGradientLayer()
    override func viewDidLoad() {
        setTableView()
        setLayout()
//        setGradient()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        gradient.removeFromSuperlayer()
        navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
//        setGradient()
        updateTableView()
    }
    
    let imageView = {
        let image = UIImageView()
//        image.image = UIImage(named: "Search 3")
        return image
    }()
    
    let nameLabel = {
        let label = UILabel()
//        label.text = "Reasonable Doubt"
        label.font = UIFont(name: "CircularStd-Bold", size: 24)
        label.textColor = .white
        label.clipsToBounds = true
        return label
    }()
    
    let artistImageView = {
        let image = UIImageView()
//        image.image = UIImage(named: "jayz")
        return image
    }()
    
    let artistNameLabel = {
        let label = UILabel()
//        label.text = "JAY-Z"
        label.font = UIFont(name: "Inter-Bold", size: 13)
        label.textColor = .white
        label.clipsToBounds = true

        return label
    }()
    
    let infoLabel = {
        let label = UILabel()
        label.text = "Album • 1996"
        label.font = UIFont(name: "CircularStd-Book", size: 13)
        label.textColor = hexStringToUIColor(hex: "#BABBBA")
        label.clipsToBounds = true

        return label
    }()
    
    let heartBtn = {
        let button = UIButton()
        button.setImage(UIImage(named: "heart"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let downloadBtn = {
        let button = UIButton()
        button.setImage(UIImage(named: "download"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let menuBtn = {
        let button = UIButton()
        button.setImage(UIImage(named: "menu"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let shuffleBtn = {
        let button = UIButton()
        button.setImage(UIImage(named: "shuffle"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let playBtn = {
        let button = UIButton()
        button.setImage(UIImage(named: "play circle"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let songTableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = hexStringToUIColor(hex: "#121212").withAlphaComponent(0.8)
//        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        return tableView
    }()
    func removeGradient(){
        self.view.layer.sublayers!.remove(at: 0)
    }
    func setGradient(color : CGColor){
        let colors = [color,
                      UIColor(red: 0.071, green: 0.071, blue: 0.071, alpha: 1).cgColor
        ]
//        view.backgroundColor = UIColor(red: 0.294, green: 0.294, blue: 0.294, alpha: 1)
//        view.backgroundColor = UIColor(cgColor: colors[0])
      print("set graident")
        print(colors)
        
        gradient.colors = colors
        gradient.locations = [0, 0.48]
        
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        
        gradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        
        gradient.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        gradient.position = view.center
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    func setTableView(){
        songTableView.delegate = self
        songTableView.dataSource = self
        songTableView.register(SongTableViewCell.self, forCellReuseIdentifier: "songCell")
    }
    
    func updateTableView(){
        songTableView.snp.updateConstraints{ tableView in
            if isPlayingViewVisible {
                tableView.bottom.equalToSuperview().offset(-1 * playingView.frame.height)
            }else{
                tableView.bottom.equalToSuperview()
            }
            
        }
    }
    
    func setLayout(){
        view.addSubview(imageView)
        view.addSubview(songTableView)
        view.addSubview(nameLabel)
        view.addSubview(artistImageView)
        view.addSubview(artistNameLabel)
        view.addSubview(infoLabel)
        
        view.addSubview(heartBtn)
        view.addSubview(downloadBtn)
        view.addSubview(shuffleBtn)
        view.addSubview(menuBtn)
        view.addSubview(playBtn)
        
        imageView.snp.makeConstraints{ image in
            image.width.equalTo(convertWidth(originValue: 246.0))
            image.height.equalTo(convertHeight(originValue: 246.0))
            image.top.equalToSuperview().offset(convertHeight(originValue: 58.0))
            image.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints{ label in
            label.width.lessThanOrEqualTo(convertWidth(originValue: 200.0))
            label.top.equalTo(imageView.snp.bottom).offset(convertHeight(originValue: 10.0))
            label.left.equalToSuperview().offset(convertWidth(originValue: 16.0))
        }
        
        artistImageView.snp.makeConstraints{ image in
            image.top.equalTo(nameLabel.snp.bottom).offset(convertHeight(originValue: 4.0))
            image.left.equalToSuperview().offset(convertWidth(originValue: 16.0))
            image.width.equalTo(convertWidth(originValue: 20.0))
            image.height.equalTo(convertHeight(originValue: 20.0))
        }
        
        artistNameLabel.snp.makeConstraints{ label in
            label.left.equalTo(artistImageView.snp.right).offset(convertWidth(originValue: 8.0))
            label.top.equalTo(nameLabel.snp.bottom).offset(convertHeight(originValue: 7.0))
            label.width.lessThanOrEqualTo(convertWidth(originValue: 172.0))
        }
        
        infoLabel.snp.makeConstraints{ label in
            label.top.equalTo(artistNameLabel.snp.bottom).offset(convertHeight(originValue: 7.0))
            label.left.equalToSuperview().offset(convertWidth(originValue: 16.0))
        }
        
        
        
        
        heartBtn.snp.makeConstraints{ button in
            button.width.equalTo(convertWidth(originValue: 22.0))
            button.height.equalTo(convertHeight(originValue: 22.0))
            button.left.equalToSuperview().offset(convertWidth(originValue: 15.0))
            button.top.equalTo(infoLabel.snp.bottom).offset(convertHeight(originValue: 15.0))
        }
        
        downloadBtn.snp.makeConstraints{ button in
            button.width.equalTo(heartBtn.snp.width)
            
            button.height.equalTo(heartBtn.snp.height)
            button.left.equalTo(heartBtn.snp.right).offset(convertWidth(originValue: 22.0))
            button.top.equalTo(heartBtn.snp.top)
        }
        
        menuBtn.snp.makeConstraints{ button in
            button.width.equalTo(convertWidth(originValue: 17.0))
            button.height.equalTo(convertHeight(originValue: 3.0))
            button.centerY.equalTo(downloadBtn.snp.centerY)
            button.left.equalTo(downloadBtn.snp.right).offset(convertWidth(originValue: 22.0))
        }
        
        playBtn.snp.makeConstraints{ button in
            button.width.equalTo(convertWidth(originValue: 48.0))
            button.height.equalTo(convertHeight(originValue: 48.0))
            button.right.equalToSuperview().offset(-1 * convertWidth(originValue: 16.0))
            button.centerY.equalTo(downloadBtn.snp.centerY)
        }
        
        shuffleBtn.snp.makeConstraints{ button in
            button.width.equalTo(downloadBtn.snp.width)
            button.height.equalTo(downloadBtn.snp.height)
            button.right.equalTo(playBtn.snp.left).offset(-1 * convertWidth(originValue: 16.0))
            button.centerY.equalTo(playBtn.snp.centerY)
        }
        
        
        
        songTableView.snp.makeConstraints{ tableView in
            
            tableView.top.equalTo(playBtn.snp.bottom).offset(convertHeight(originValue: 10.0))
            tableView.left.right.equalToSuperview()
            if isPlayingViewVisible {
                tableView.bottom.equalToSuperview().offset(-1 * playingView.frame.height)
            }else{
                tableView.bottom.equalToSuperview()
            }
            
        }
        
    }
    
    func getColors(image : UIImage){
//        var result = [CGColor]()
        image.getColors{ color in
//            result.append((color?.primary.withAlphaComponent(0.5).cgColor)!)
//            result.append((color?.secondary.withAlphaComponent(0.9).cgColor)!)
            self.setGradient(color:(color?.secondary.withAlphaComponent(0.8).cgColor)!)
        }
    }
    
    func configure(album : Album){
        //여기서 뷰 세팅
        songs = album.songs
        let image = UIImage(named: album.imageName)
        songTableView.reloadData()

        getColors(image: image!)
        
       // print(album.imageName)]//
        imageView.image = image
        nameLabel.text = album.name
        artistNameLabel.text = album.artist.name
        artistImageView.image = UIImage(named: album.artist.imageName)
        
    }
    
    
}

extension AlbumListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = songTableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as? SongTableViewCell else {
            return SongTableViewCell()
        }
        
        cell.configure(music: songs[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return convertHeight(originValue: 64.0)
    }
    
    
}
