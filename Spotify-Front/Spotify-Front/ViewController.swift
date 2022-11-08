import UIKit

class ViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradient()
        setLayout()
        setCollectionView()
        
    }
    
    let data = [Playlist(name: "It's Only Me", imageName: "Image 1"), Playlist(name: "Lead Position", imageName: "Image 2"), Playlist(name: "DRILL MUSIC IN ZION", imageName: "Image 3"), Playlist(name: "GOD DID", imageName: "Image 4"), Playlist(name: "EGOT the EP", imageName: "Image 5"), Playlist(name: "Enter The Wu-Tang (36 Chambers)", imageName: "Image 6")]
    
    func setCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PlaylistCollectionViewCell.self, forCellWithReuseIdentifier: "playlistCell")
    }
    func setLayout(){
        view.addSubview(bellButton)
        view.addSubview(clockButton)
        view.addSubview(settingButton)
        view.addSubview(greetLabel)
        view.addSubview(collectionView)
        
        //bell button auto layout
        
        bellButton.widthAnchor.constraint(equalToConstant: convertWidth(originValue: 19.0)).isActive = true
        bellButton.heightAnchor.constraint(equalToConstant: convertHeight(originValue: 21.0)).isActive = true
        bellButton.topAnchor.constraint(equalTo: view.topAnchor, constant: convertHeight(originValue: 82.0)).isActive = true
        bellButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: convertWidth(originValue: 242.0)).isActive = true
        
        //clock button auto layout
        clockButton.widthAnchor.constraint(equalToConstant: convertWidth(originValue: 22.0)).isActive = true
        clockButton.heightAnchor.constraint(equalToConstant: convertHeight(originValue: 22.0)).isActive = true
        clockButton.topAnchor.constraint(equalTo: view.topAnchor, constant: convertHeight(originValue: 81.0)).isActive = true
        clockButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: convertWidth(originValue: 288.5)).isActive = true
        
        
        
        //setting button auto layout
        settingButton.widthAnchor.constraint(equalToConstant: convertWidth(originValue: 24.3)).isActive = true
        settingButton.heightAnchor.constraint(equalToConstant: convertHeight(originValue: 23.85)).isActive = true
        settingButton.topAnchor.constraint(equalTo: view.topAnchor, constant: convertHeight(originValue: 80.0)).isActive = true
        settingButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: convertWidth(originValue: 335.5)).isActive = true
        
        //greet label auto layout
        greetLabel.widthAnchor.constraint(equalToConstant: convertWidth(originValue: 191.0)).isActive = true
        greetLabel.heightAnchor.constraint(equalToConstant: convertHeight(originValue: 50.0)).isActive = true
        greetLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        greetLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: convertHeight(originValue: 68.0)).isActive = true
        
        //collection View auto layout
        
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: convertWidth(originValue: 15.0)).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -1 * convertWidth(originValue: 15.0)).isActive = true
        collectionView.topAnchor.constraint(equalTo: settingButton.bottomAnchor, constant: convertHeight(originValue: 20.0)).isActive = true
        collectionView.widthAnchor.constraint(equalToConstant: convertWidth(originValue: 344.0)).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: convertHeight(originValue: 186.0)).isActive = true
//        collectionView.clipsToBounds
//        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        collectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
//        collectionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        
        
        
        
    }
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let greetLabel : UILabel = {
        let label = UILabel()
        label.text = "Good afternoon"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "CircularStd-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bellButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bell"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let clockButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "clock"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let settingButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "setting"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
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
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playlistCell", for: indexPath) as? PlaylistCollectionViewCell else{
            return PlaylistCollectionViewCell()
        }
        cell.configure(playlist: data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: convertWidth(originValue: 167.0), height: convertHeight(originValue: 56.0))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return convertHeight(originValue: 8.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return convertWidth(originValue: 10.0)
    }
    
    
}
