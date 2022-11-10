import UIKit
import SnapKit
class ViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        setGradient()
        setLayout()
        setCollectionView()
        
    }
    
    let playlists = [Playlist(name: "It's Only Me", imageName: "Image 1"), Playlist(name: "Lead Position", imageName: "Image 2"), Playlist(name: "DRILL MUSIC IN ZION", imageName: "Image 3"), Playlist(name: "GOD DID", imageName: "Image 4"), Playlist(name: "EGOT the EP", imageName: "Image 5"), Playlist(name: "Enter The Wu-Tang (36 Chambers)", imageName: "Image 6")]
    
    let episodes = [Episode(name: "Things You Thought You Knew - What Is Exit Velocity?", imageName: "Image 7", content: "What is exit velocity? On this episode, Neil deGrasse Tyson asks", day: "Wed", length: "1hr, 5min"), Episode(name: "211 - How to give and receive feedback - with Eric Moore", imageName: "Image 8", content: "Criticism is easily given, but rarely appreciated. At some point", day: "Fri", length: "53 min"), Episode(name: "Things You Thought You Knew - What Is Exit Velocity?", imageName: "Image 7", content: "What is exit velocity? On this episode, Neil deGrasse Tyson asks", day: "Wed", length: "1hr, 5min"), Episode(name: "Things You Thought You Knew - What Is Exit Velocity?", imageName: "Image 7", content: "What is exit velocity? On this episode, Neil deGrasse Tyson asks", day: "Wed", length: "1hr, 5min")]
    
 
    
    func setCollectionView(){
        playlistCollectionView.delegate = self
        playlistCollectionView.dataSource = self
        playlistCollectionView.register(PlaylistCollectionViewCell.self, forCellWithReuseIdentifier: "playlistCell")
        
        episodeCollectionView.delegate = self
        episodeCollectionView.dataSource = self
        episodeCollectionView.register(EpisodeCollectionViewCell.self, forCellWithReuseIdentifier: "episodeCell")
        
        
    }
    
    func setLayout(){
        view.addSubview(bellButton)
        view.addSubview(clockButton)
        view.addSubview(settingButton)
        view.addSubview(greetLabel)
        view.addSubview(playlistCollectionView)
        view.addSubview(episodeCollectionView)
        view.addSubview(episodeLabel)
        
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
        return button
    }()
    
    func setGradient(){
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
extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.playlistCollectionView{
            return playlists.count

        }else{
            return episodes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.playlistCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playlistCell", for: indexPath) as? PlaylistCollectionViewCell else{
                return PlaylistCollectionViewCell()
            }
            cell.configure(playlist: playlists[indexPath.row])
            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "episodeCell", for: indexPath) as? EpisodeCollectionViewCell else{
                return EpisodeCollectionViewCell()
            }
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
