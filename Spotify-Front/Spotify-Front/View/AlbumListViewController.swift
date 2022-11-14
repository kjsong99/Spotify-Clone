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
  
            
        override func viewDidLoad() {
            super.viewDidLoad()
            setLayout()
            
        }
    
    let waveFormView = {
       let view = WaveformZoomable()
        let file  = Bundle.main.url(forResource: "Music 1", withExtension: "mp3")
        let image = UIImage(named: "Search 3")
        image!.getColors{ color in
            view.backgroundColor = color?.detail
        }
        view.openFile(file!)
        return view
    }()
        
    
    func setLayout(){
        view.addSubview(waveFormView)
        waveFormView.snp.makeConstraints{ view in
            view.centerY.centerX.equalToSuperview()
            view.width.equalTo(convertWidth(originValue: 167.0))
            view.height.equalTo(convertHeight(originValue: 42.0))
        }
    }
}

