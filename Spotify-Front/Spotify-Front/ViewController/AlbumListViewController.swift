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
import FlexibleHeader

class AlbumListViewController: UIViewController, UIScrollViewDelegate{
    
    // MARK: - Override, Init
    
    override func viewDidLoad() {
        scrollView.delegate = self
//        setLayout()
//        setTableView()
        getAlbum()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        gradient.removeFromSuperlayer()
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateTableView()
        super.viewWillAppear(animated)
    }
    
    init(data: Search, image: UIImage, color: CGColor){
        self.data = data
        self.image = image
        self.color = color
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    func setTableView()  {
        //        self.navigationController?.navigationBar.topItem?.title = "타이틀 2"
        
        songTableView.delegate = self
        songTableView.dataSource = self
        songTableView.register(SongCell.self, forCellReuseIdentifier: SongCell.identifier)
    }
    
    
    
    
    private func layout() {
        scrollView.showsHorizontalScrollIndicator = false
        flexibleHeader!.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        flexibleHeader!.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        flexibleHeader!.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        let flexibleHeaderHeight = flexibleHeader!.heightAnchor.constraint(equalToConstant: 0)
        flexibleHeaderHeight.isActive = true
        
        flexibleHeader!.configure(heightConstraint: flexibleHeaderHeight)
        
        scrollView.topAnchor.constraint(equalTo: flexibleHeader!.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
//        layoutScrollView()
    }
    
    private func layoutScrollView(count : Int) {
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: convertHeight(originValue: 300) + convertHeight(originValue: 64) * Double(count)).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        flexibleHeader!.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: flexibleHeader!.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: flexibleHeader!.topAnchor, constant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        let headerContentViewWidth = imageView.widthAnchor.constraint(equalToConstant: 0)
        headerContentViewWidth.isActive = true
        
        let initialConstraintConstant = ProgressiveLayoutConstraintConstant(constraint: headerContentViewWidth, progress: 0.0, constant: convertWidth(originValue: 256))
        let finalConstraintConstant = ProgressiveLayoutConstraintConstant(constraint: headerContentViewWidth, progress: 1.0, constant: 0)
        flexibleHeader!.appendProgressiveConstraintConstant(with: initialConstraintConstant)
        flexibleHeader!.appendProgressiveConstraintConstant(with: finalConstraintConstant)
   
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if flexibleHeader?.progress == 1 {
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }else{
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        }
        let contentYOffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYOffset
        
//        if distanceFromBottom < height {
//            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        }else{
//            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
//        }
    }
    
    
    
    func setLayout(count: Int)  {
        flexibleHeader = FlexibleHeader(scrollView: scrollView, maxHeight: convertHeight(originValue: 150), minHeight: 0, executantType: .threshold)
        flexibleHeader!.translatesAutoresizingMaskIntoConstraints = false
        flexibleHeader!.backgroundColor = .clear
        let initialAttribute = ProgressiveViewAttribute(view: flexibleHeader!, progress: 0.0, alpha: 1.0)
        let finalAttribute = ProgressiveViewAttribute(view: flexibleHeader!, progress: 1.0, alpha: 0.0)
        flexibleHeader!.appendProgressiveViewAttribute(with: initialAttribute)
        flexibleHeader!.appendProgressiveViewAttribute(with: finalAttribute)
        view.backgroundColor = .clear
        view.addSubview(flexibleHeader!)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        layout()
        
        contentView.addSubview(songTableView)
//        contentView.addSubview(topView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(artistImageView)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(infoLabel)
        contentView.addSubview(heartBtn)
        contentView.addSubview(downloadBtn)
        contentView.addSubview(shuffleBtn)
        contentView.addSubview(menuBtn)
        contentView.addSubview(playBtn)
        imageView.image = image
        
        nameLabel.snp.makeConstraints{ label in
            label.width.lessThanOrEqualTo(convertWidth(originValue: 200.0))
            label.top.equalToSuperview().offset(convertHeight(originValue: 100.0))
            label.left.equalToSuperview().offset(convertWidth(originValue: 16.0))
        }
        
        artistImageView.snp.makeConstraints{ image in
            image.top.equalTo(nameLabel.snp.bottom).offset(convertHeight(originValue: 4.0))
            image.left.equalToSuperview().offset(convertWidth(originValue: 16.0))
            image.width.equalTo(convertWidth(originValue: 20.0))
            image.height.equalTo(convertHeight(originValue: 20.0))
        }
        //
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
            tableView.height.equalTo(convertHeight(originValue: 64) * Double(count))
            //            if isPlayingViewVisible {
            //                tableView.bottom.equalToSuperview().offset(-1 * playingView.frame.height)
            //            }else{
            //                tableView.bottom.equalTo(self.view.snp.bottom)
            //            }
            
        }
        
        gradientView.getGradient(color: UIColor(cgColor: color))
        view.insertSubview(gradientView, at: 0)
        
    }
    
    // MARK: - Variable
    
    
    
    let gradient = CAGradientLayer()
    var songs = [Music]()
    var album : Album?
    var data : Search
    var color : CGColor
    var image : UIImage
    private var flexibleHeader: FlexibleHeader?
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    
    
    let gradientView = {
        let temp = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        return temp
    }()
    
    
    let imageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
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
        tableView.backgroundColor = hexStringToUIColor(hex: "#121212").withAlphaComponent(0.7)
        //        tableView.backgroundColor = .clear
        
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    let topView = {
       let view = UIView()
        return view
    }()
    
    
    
    func updateTableView()  {
        songTableView.snp.updateConstraints{ tableView in
            if isPlayingViewVisible {
                //                tableView.bottom.equalToSuperview().offset(-1 * playingView.frame.height)
            }else{
                //                tableView.bottom.equalToSuperview()
            }
            
        }
    }
    
    // MARK: - Function
    
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.navigationItem.title = data.name
    }
    //completion: @escaping (Result<Album, Error>) -> Void
    func configure(album: Album) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        //        self.navigationItem.title = album.name
        self.songs = album.musics
        setTableView()
//        self.songTableView.reloadData()
//        layout()
        setLayout(count: album.musics.count)

        layoutScrollView(count: album.musics.count)
       
        self.nameLabel.text = album.name
        self.artistNameLabel.text = album.artist.name
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

// MARK: - Extension
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

