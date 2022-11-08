import UIKit

class ViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradient()
        setLayout()

    }
    
    func setLayout(){
        view.addSubview(bellButton)
        view.addSubview(clockButton)
        view.addSubview(settingButton)
        view.addSubview(greetLabel)
        
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
        


        

    }
    
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
