//
//  SearchViewController.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/11.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.hideKeyboardWhenTappedAround()
        setLayout()
        setTableView()
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.backButtonTitle = ""
        
    }
    
    func setLayout(){
        
        view.backgroundColor = hexStringToUIColor(hex: "#191919").withAlphaComponent(0.5)
        view.addSubview(searchFieldView)
        searchFieldView.addSubview(searchField)
        searchFieldView.addSubview(searchImage)
        searchFieldView.addSubview(initBtn)
        view.addSubview(cancelBtn)
        view.addSubview(recentLabel)
        view.addSubview(searchHistoryTableView)
        
        searchFieldView.snp.makeConstraints{ view in
            view.width.equalTo(convertWidth(originValue: 285.0))
            view.height.equalTo(convertHeight(originValue: 30.0))
            view.top.equalTo(self.view.safeAreaLayoutGuide).offset(convertHeight(originValue: 8.0))
            view.left.equalToSuperview().offset(convertWidth(originValue: 16.0))
        }
        
        searchImage.snp.makeConstraints{ image in
            image.width.equalTo(convertWidth(originValue: 19.0))
            image.height.equalTo(convertHeight(originValue: 19.0))
            image.left.equalToSuperview().offset(convertWidth(originValue: 10.0))
            image.centerY.equalToSuperview()
        }
        
        initBtn.snp.makeConstraints{ btn in
            btn.width.equalTo(searchImage)
            btn.height.equalTo(searchImage)
            btn.right.equalToSuperview().offset(-1 * 10.0)
            btn.centerY.equalToSuperview()
        }
        
        searchField.snp.makeConstraints{ field in
            //            field.centerX.equalToSuperview()
            field.centerY.equalToSuperview()
            field.width.lessThanOrEqualToSuperview()
            field.height.equalTo(convertHeight(originValue: 16.0))
            field.left.equalTo(searchImage.snp.right).offset(10.0)
            field.right.equalToSuperview().offset(-1 * convertWidth(originValue: 29.0))
        }
        
        cancelBtn.snp.makeConstraints{ btn in
            btn.width.equalTo(convertWidth(originValue: 46.0))
            btn.height.equalTo(convertHeight(originValue: 16.0))
            btn.left.equalTo(searchFieldView.snp.right).offset(convertWidth(originValue: 13.0))
            btn.top.equalTo(self.view.safeAreaLayoutGuide).offset(convertHeight(originValue: 15.0))
        }
        
        recentLabel.snp.makeConstraints{ label in
            label.width.equalTo(convertWidth(originValue: 158.0))
            label.height.equalTo(convertHeight(originValue: 17.0))
            label.top.equalTo(searchFieldView.snp.bottom).offset(convertHeight(originValue: 21.0))
            label.left.equalToSuperview().offset(convertWidth(originValue: 16.0))
        }
        
        searchHistoryTableView.snp.makeConstraints{ tableView in
            tableView.left.equalToSuperview().offset(convertWidth(originValue: 16.0))
            tableView.right.equalToSuperview().offset(-1 * convertWidth(originValue: 14.0))
            tableView.top.equalTo(recentLabel.snp.bottom).offset(convertHeight(originValue: 19.0))
            tableView.bottom.equalToSuperview()
        }
    }
    
    func setTableView(){
        searchHistoryTableView.backgroundColor = .black
        searchHistoryTableView.dataSource = self
        searchHistoryTableView.delegate = self
        searchHistoryTableView.register(SearchHistoryTableViewCell.self, forCellReuseIdentifier: "searchHistoryCell")
    }
    
    // MARK: - UI Variable
    

    
    let searchFieldView : UIView = {
        let view = UIView()
        view.backgroundColor = hexStringToUIColor(hex: "#242424")
        view.layer.cornerRadius = 8.0
        return view
    }()
    let searchImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "search")
        image.tintColor = .white
        return image
    }()
    
    let searchField : UITextField = {
        let field = UITextField()
        field.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
        field.placeholder = "What do you want to listen to?"
        field.font =  UIFont(name: "CircularStd-Book", size: 16)
        field.textAlignment = .left
        field.textColor = .white
        field.isUserInteractionEnabled = true
        field.setPlaceholder(color: hexStringToUIColor(hex: "#A7A7A7"))
        
        return field
    }()
    
    let initBtn : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.isHidden = true
        button.addTarget(self, action: #selector(initText), for: .touchDown)
        return button
    }()
    
    let cancelBtn : UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont(name: "CircularStd-Book", size: 13)
        button.tintColor = .white
        return button
    }()
    
    let recentLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "CircularStd-Bold", size: 16)
        label.text = "Recent searches"
        label.textColor = .white
        return label
    }()
    
    let searchHistoryTableView : UITableView = {
        let tableView = UITableView()
        tableView.isHidden = false
        return tableView
    }()
    
    let SearchTableView : UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        return tableView
    }()
    
    // MARK: - Function
    
    
    @objc func textDidChanged(_sender: Any?){
        if self.searchField.text?.count != 0 {
            initBtn.isHidden = false
            self.searchHistoryTableView.isHidden = true
            self.SearchTableView.isHidden = false
        }else{
            initBtn.isHidden = true
            self.searchHistoryTableView.isHidden = false
            self.SearchTableView.isHidden = true
        }
    }
    
    @objc func initText(){
        self.searchField.text = ""
        self.initBtn.isHidden = true
        self.searchHistoryTableView.isHidden = false
        self.SearchTableView.isHidden = true
    }
    
}

// MARK: - Extension

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AlbumListViewController()
        vc.configure()
        show(vc, sender: self)
//        self.navigationController?.pushViewControllerFromLeft(viewControlller: vc)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = searchHistoryTableView.dequeueReusableCell(withIdentifier: "searchHistoryCell", for: indexPath) as? SearchHistoryTableViewCell else {
            return SearchHistoryTableViewCell()
        }
        cell.selectionStyle = .none
        //cell configure
//        cell.configure(search: histories[indexPath.row])
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(handleRegister), for: .touchDown)
        
        
        return cell
    }
    @objc func handleRegister(_ sender: UIButton){
//        histories.remove(at:sender.tag)
        searchHistoryTableView.deleteRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
        searchHistoryTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return convertHeight(originValue: 56.0)
    }
    
    
    
    
    
}
extension UITextField {
    func setPlaceholder(color: UIColor) {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
}

extension UINavigationController{
    func pushViewControllerFromLeft(viewControlller : UIViewController){
        let transition = CATransition()
        transition.duration = 0.1
        transition.type = .moveIn
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        view.window?.layer.add(transition, forKey: kCATransition)
        pushViewController(viewControlller, animated: false)
        self.setNavigationBarHidden(false, animated: false)
        
    }
    
    func popViewControllerToLeft(){
        let transition = CATransition()
        transition.duration = 0.1
        transition.type = .moveIn
        transition.subtype = .fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        view.window?.layer.add(transition, forKey: kCATransition)
        
        popViewController(animated: false)
        self.setNavigationBarHidden(true, animated: false)
        
    }
}
