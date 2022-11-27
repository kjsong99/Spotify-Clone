import UIKit
import SnapKit
class HomeViewController: UIViewController{
    
    // MARK: - Override, Init
    
    override func viewDidLoad() {
        setGradient()
        setLayout()
        setCollectionView()
    }
    
    func setCollectionView(){
        playlistCollectionView.delegate = self
        playlistCollectionView.dataSource = self
        playlistCollectionView.register(PlaylistCell.self, forCellWithReuseIdentifier: PlaylistCell.identifier)
        playlistCollectionView.backgroundColor = .black
        
        episodeCollectionView.delegate = self
        episodeCollectionView.dataSource = self
        episodeCollectionView.register(EpisodeCell.self, forCellWithReuseIdentifier: EpisodeCell.identifier)
        episodeCollectionView.backgroundColor = .black
        
        
    }
    
    func setLayout(){
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(mainView)
        scrollView.contentInsetAdjustmentBehavior = .never

        mainView.addSubview(bellButton)
        mainView.addSubview(clockButton)
        mainView.addSubview(settingButton)
        mainView.addSubview(greetLabel)
        mainView.addSubview(playlistCollectionView)
        mainView.addSubview(episodeCollectionView)
        mainView.addSubview(episodeLabel)
        
        scrollView.snp.makeConstraints{ view in
            view.left.right.top.width.equalToSuperview()
            view.height.equalToSuperview()
            view.bottom.equalToSuperview()
            
        }
        mainView.snp.makeConstraints{ view in
            
           
            view.width.equalTo(scrollView.frameLayoutGuide)
            view.left.right.equalToSuperview()
            view.top.equalToSuperview()
            view.bottom.equalToSuperview()
            view.height.equalTo(scrollView.snp.height).multipliedBy(2)
            
            
            
        }
        
        bellButton.snp.makeConstraints{ make in
            make.width.equalTo(convertWidth(originValue: 19.0))
            make.height.equalTo(convertHeight(originValue: 21.0))
            make.top.equalToSuperview().offset(convertHeight(originValue: 82.0))
            make.right.equalTo(clockButton.snp.left).offset(-1 * convertWidth(originValue: 27.5))
            
        }
        
        clockButton.snp.makeConstraints{ make in
            make.width.equalTo(convertWidth(originValue: 22.0))
            make.height.equalTo(convertHeight(originValue: 22.0))
            make.top.equalToSuperview().offset(convertHeight(originValue: 82.0))
            make.right.equalTo(settingButton.snp.left).offset(-1 * convertWidth(originValue: 25.5))
        }
        
        settingButton.snp.makeConstraints{ make in
            make.width.equalTo(convertWidth(originValue: 24.3))
            make.height.equalTo(convertHeight(originValue: 23.85))
            make.top.equalToSuperview().offset(convertHeight(originValue: 80.0))
            make.right.equalToSuperview().offset(-1 * convertWidth(originValue: 15.2))
        }
    
        greetLabel.snp.makeConstraints{ make in
            make.width.equalTo(convertWidth(originValue: 191.0))
            make.height.equalTo(convertHeight(originValue: 50.0))
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(convertHeight(originValue: 68.0))
        }
        
        playlistCollectionView.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(convertWidth(originValue: 15.0))
            make.right.equalToSuperview().offset(-1 * convertWidth(originValue: 15.0))
            make.top.equalTo(greetLabel.snp.bottom).offset(convertHeight(originValue: 6.0))
            make.width.equalTo(convertWidth(originValue: 344.0))
            make.height.equalTo(convertHeight(originValue: 186.0))
        }
        
        episodeLabel.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(convertWidth(originValue: 6.0))
            make.top.equalTo(playlistCollectionView.snp.bottom).offset(convertHeight(originValue: 8.0))
            make.width.equalTo(convertWidth(originValue: 166.0))
            make.height.equalTo(convertHeight(originValue: 50.0))
        }
        
        episodeCollectionView.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(convertWidth(originValue: 16.0))
            make.top.equalTo(episodeLabel.snp.bottom).offset(convertHeight(originValue: 4.0))
            make.height.equalTo(convertHeight(originValue: 225.0))
            make.right.equalToSuperview()
        }
        
    }
    
    // MARK: - Variable
    
    let scrollView : UIScrollView = {
       let view = UIScrollView()
        return view
    }()
    
    let mainView : UIView = {
        let view = UIView()
        return view
    }()
    
    let playlistCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    let episodeCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    let greetLabel : UILabel = {
        let label = UILabel()
        label.text = "Good afternoon"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "CircularStd-Bold", size: 24)
        return label
    }()
    
    let episodeLabel : UILabel = {
        let label = UILabel()
        label.text = "New Episodes"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "CircularStd-Bold", size: 24)
        return label
    }()
    
    let bellButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bell"), for: .normal)
        return button
    }()
    
    let clockButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "clock"), for: .normal)
        return button
    }()
    
    let settingButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "setting"), for: .normal)
        button.addTarget(self, action: #selector(makePlayingViewHidden), for: .touchDown)
        return button
    }()
    
    // MARK: - Functions
    
    @objc func makePlayingViewHidden(){
        if isPlayingViewVisible {
            playingView.isHidden = true
            isPlayingViewVisible = false

        }else{
            playingView.isHidden = false
            isPlayingViewVisible = true

        }
    }
    
    // MARK: - Gradient
    
    func setGradient(){
        view.backgroundColor = hexStringToUIColor(hex: "#957C4D")
        let gradient = CAGradientLayer()
        gradient.colors = [
            hexStringToUIColor(hex: "#957C4D").withAlphaComponent(0.7).cgColor,
            hexStringToUIColor(hex: "#121212").cgColor,
            hexStringToUIColor(hex: "#121212").cgColor,
            hexStringToUIColor(hex: "#121212").cgColor,
            hexStringToUIColor(hex: "#121212").cgColor,
            hexStringToUIColor(hex: "#121212").cgColor,
            hexStringToUIColor(hex: "#121212").cgColor,
        ]
        
        gradient.type = .axial
        gradient.startPoint = CGPoint(x: 0.1, y: 0.3)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.35)
        gradient.locations = [0.02, 0.18, 0.18, 0.18, 0.18, 0.18, 0.18]
        gradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(rotationAngle: 0.7))
        gradient.bounds = view.layer.bounds.insetBy(dx:-0.5 * view.layer.bounds.size.width, dy: -0.5 * view.layer.bounds.size.height)
        gradient.position = view.center
        view.layer.addSublayer(gradient)
    }
    
    
}


// MARK: - Extension
extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.playlistCollectionView{
            return playlists.count

        }else{
            return episodes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.playlistCollectionView{
           
            let cell = playlistCollectionView.dequeueCell(type: PlaylistCell.self, indexPath: indexPath)
            cell.configure(playlist: playlists[indexPath.row])
            return cell
        }else{
            let cell = collectionView.dequeueCell(type: EpisodeCell.self, indexPath: indexPath)
            cell.configure(episode: episodes[indexPath.row])
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.playlistCollectionView{
            return CGSize(width: convertWidth(originValue: 167.0), height: convertHeight(originValue: 56.0))
        }else{
            return CGSize(width: convertWidth(originValue: 309.0), height: convertHeight(originValue: 104.0))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.playlistCollectionView{
            return convertHeight(originValue: 8.0)
        }else{
            return convertHeight(originValue: 16.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.playlistCollectionView{
            return convertWidth(originValue: 9.0)
        }else{
            return convertWidth(originValue: 16.0)
        }
    }
    
    
}
