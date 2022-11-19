//
//  TestViewController.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/18.
//

import UIKit
import SnapKit
import Kingfisher

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        
    }
    
    let imageView = {
        let view = UIImageView()
        return view
    }()
    
    func setLayout(){
        view.addSubview(imageView)
        imageView.snp.makeConstraints{ view in
            view.left.right.top.bottom.equalToSuperview()
        }
    }
    

}
