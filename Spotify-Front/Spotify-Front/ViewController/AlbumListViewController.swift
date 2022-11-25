//
//  AlbumListView.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/14.
//

import UIKit
import SnapKit
import UIImageColors
import Moya
import Kingfisher

class AlbumListViewController: UIViewController {
    var songs = [Music]()
    var album : Album?
    var data : Search
    var color : CGColor
    var image : UIImage
    
    init(data: Search, image: UIImage, color: CGColor){
        self.data = data
        self.image = image
        self.color = color
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    func getAlbum() {
        AlbumService.shared.requestAlbum(albumId: data.value_id){ result in
            switch result {
            case let .success(result):
                self.configure(album: result)

                
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
  
    let gradient = CAGradientLayer()
    
    override func viewDidLoad() {
        setLayout()
        setTableView()
        getAlbum()
    }
    
 
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        gradient.removeFromSuperlayer()
        navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewWillDisappear(animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        updateTableView()
    }
    

    let gradientView = {
//        let view =  UIView(frame: CGRect(x: 50, y: 50, width: 256, height: 256))
        let temp = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        return temp
    }()
    
    let imageView = {
        let image = UIImageView()
        return image
    }()
    
    let nameLabel = {
        let label = UILabel()
        label.font = UIFont(name: "CircularStd-Bold", size: 24)
        label.textColor = .white
        label.clipsToBounds = true
        return label
    }()
    
    let artistImageView = {
        let image = UIImageView()
        return image
    }()
    
    let artistNameLabel = {
        let label = UILabel()
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
//        tableView.backgroundColor = .clear
        tableView.backgroundColor = hexStringToUIColor(hex: "#121212").withAlphaComponent(0.2)
        //        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    func setTableView()  {
        
        songTableView.delegate = self
        songTableView.dataSource = self
        songTableView.register(SongCell.self, forCellReuseIdentifier: SongCell.identifier)
    }
    
    func updateTableView()  {
        songTableView.snp.updateConstraints{ tableView in
            if isPlayingViewVisible {
                tableView.bottom.equalToSuperview().offset(-1 * playingView.frame.height)
            }else{
                tableView.bottom.equalToSuperview()
            }
            
        }
    }
    
    func setLayout()  {
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
        imageView.image = image
        
        
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
        
        gradientView.getGradient(color: UIColor(cgColor: color))
        view.insertSubview(gradientView, at: 0)
     
    }
    //completion: @escaping (Result<Album, Error>) -> Void
    func configure(album: Album) {
        self.songs = album.musics
        self.songTableView.reloadData()
      
        self.nameLabel.text = album.name
        self.artistNameLabel.text = album.artist.name
//        self.imageView.kf.setImage(with: URL(string: album.imagePath), placeholder: UIImage(named: "Placeholder"))
//        downloadImage(with: "http://localhost:8080/" + album.imagePath){ result in
//            switch result {
//            case let .success(result):
//
//                self.imageView.image = result
//                self.getColors(image: result)
//
//
//
//            case let .failure(error):
//                print(error.localizedDescription)
//            }
//        }
        downloadImage(with: "http://localhost:8080/" + album.artist.imagePath){ result in
            switch result {
            case let .success(result):
                self.artistImageView.image = result
                self.artistImageView.getCircleImage()
                
            case let .failure(error):
                print(error.localizedDescription)
            }

        }
        
        
    }
}
extension AlbumListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = songTableView.dequeueCell(type: SongCell.self, indexPath: indexPath)
        
        cell.configure(music: self.songs[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return convertHeight(originValue: 64.0)
    }
    
    
}

extension UIImageView{
    func getCircleImage(){
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderWidth = 1
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.clear.cgColor
        self.contentMode = .scaleToFill
    }
    
}

extension UIView{
    func getGradient(color : UIColor){
        self.backgroundColor = color
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = self.bounds
        
        gradientMaskLayer.colors = [ UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientMaskLayer.locations = [0, 0.5]
        
        self.layer.mask = gradientMaskLayer
    }
}
