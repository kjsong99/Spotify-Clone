//
//  SearchViewController.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/11.
//

import UIKit
import SnapKit
import RealmSwift
class SearchViewController: UIViewController {
    let realm = try! Realm()
    var searchList : [Search] = [Search]()
    var histories : [Search] = [Search]()
    
    override func viewWillAppear(_ bool : Bool){
        super.viewWillAppear(bool)
       updateHistory()
        
    }
  
    func updateHistory(){
        histories.removeAll()
        let objects = realm.objects(Search.self)
        for i in objects{
            histories.append(i)
        }
        searchHistoryTableView.dataSource = self
        searchHistoryTableView.reloadData()
    }
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
        
        view.addSubview(searchHistoryView)
        view.addSubview(searchView)
        
        searchHistoryView.addSubview(recentLabel)
        searchHistoryView.addSubview(searchHistoryTableView)
        
        searchView.addSubview(SearchTableView)
        
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
            label.top.equalToSuperview().offset(convertHeight(originValue: 13.0))
            label.left.equalToSuperview().offset(convertWidth(originValue: 16.0))
        }

        searchHistoryTableView.snp.makeConstraints{ tableView in
            tableView.left.equalToSuperview()
            tableView.right.equalToSuperview()
            tableView.top.equalTo(recentLabel.snp.bottom).offset(convertHeight(originValue: 19.0))
            tableView.bottom.equalToSuperview()
        }

        SearchTableView.snp.makeConstraints{ tableView in
            tableView.left.equalToSuperview()
            tableView.right.equalToSuperview()
            tableView.top.equalToSuperview()
            tableView.bottom.equalToSuperview()
        }
        
        searchView.snp.makeConstraints{ view in
            view.width.equalToSuperview()
            view.bottom.equalToSuperview()
            view.top.equalTo(searchFieldView.snp.bottom).offset(convertHeight(originValue: 21.0))
        }
        
        searchHistoryView.snp.makeConstraints{ view in
            view.left.right.bottom.equalToSuperview()
            view.top.equalTo(searchFieldView.snp.bottom).offset(convertHeight(originValue: 8.0))
        }
    }
    
    func setTableView(){
//        searchHistoryTableView.backgroundColor = .black
        searchHistoryTableView.dataSource = self
        searchHistoryTableView.delegate = self
        searchHistoryTableView.register(SearchHistoryTableViewCell.self, forCellReuseIdentifier: "searchHistoryCell")
        
//        SearchTableView.backgroundColor = .black
        SearchTableView.dataSource = self
        SearchTableView.delegate = self
        SearchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "searchCell")
    }
    
    // MARK: - UI Variable
    

    let searchHistoryView = {
        let view = UIView()
        view.backgroundColor = hexStringToUIColor(hex: "#121212")
        view.isHidden = false
        return view
    }()
    
    let searchView = {
        let view = UIView()
        view.backgroundColor = hexStringToUIColor(hex: "#191F1F")
        view.isHidden = true
        return view
    }()
    
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
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let SearchTableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Function
    
    
    @objc func textDidChanged(_sender: Any?){
        if self.searchField.text?.count != 0 {
            initBtn.isHidden = false
            self.searchHistoryView.isHidden = true
            self.searchView.isHidden = false
            SearchService.shared.search(keyword: searchField.text!){ result in
                switch result {
                case let .success(result):
                    self.searchList = result
                    self.SearchTableView.reloadData()
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            
        }else{
            initBtn.isHidden = true
            self.searchHistoryView.isHidden = false
            self.searchView.isHidden = true
        }
    }
    
    @objc func initText(){
        self.searchField.text = ""
        self.initBtn.isHidden = true
        self.searchHistoryView.isHidden = false
        self.searchView.isHidden = true
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
        if tableView == searchHistoryTableView{
            return histories.count

        }else{
            return searchList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == searchHistoryTableView {
            guard let cell = searchHistoryTableView.dequeueReusableCell(withIdentifier: "searchHistoryCell", for: indexPath) as? SearchHistoryTableViewCell else {
                return SearchHistoryTableViewCell()
            }
            cell.selectionStyle = .none
            cell.deleteBtn.tag = indexPath.row
            cell.deleteBtn.addTarget(self, action: #selector(handleRegister(_:)), for: .touchDown)
//            cell.property = histories[indexPath.row]
            
            cell.configure(search: histories[indexPath.row])
            
            
            return cell
        }else{
            guard let cell = SearchTableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? SearchTableViewCell else {
                return SearchTableViewCell()
            }
            
            cell.selectionStyle = . none
            cell.configure(search: searchList[indexPath.row])
            cell.menuButton.addTarget(self, action: #selector(menuSheet(_:)), for: .touchDown)
            cell.goButton.addTarget(self, action: #selector(saveHistory(_:)), for: .touchDown)
            
            return cell
        }
        
    }
    
    @objc func menuSheet(_ sender: UIButton){
        print("alert")
    }
    @objc func saveHistory(_ sender: UIButton){
        let contentView = sender.superview
        let cell = contentView?.superview as! SearchTableViewCell
                
        if let indexPath = SearchTableView.indexPath(for: cell) {
            let search = searchList[indexPath.row]
            try! realm.write{
                let objects = realm.objects(Search.self)
                for i in objects {
                    if i == search {
                        return
                    }
                }
                realm.add(search)
            }
        }
        updateHistory()
        
    }
    @objc func handleRegister(_ sender: UIButton){
        let contentView = sender.superview
        let cell = contentView?.superview as! SearchHistoryTableViewCell
                
        if let indexPath = searchHistoryTableView.indexPath(for: cell) {
            try! realm.write{
                realm.delete(histories[indexPath.row])
            }
        }
        updateHistory()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return tableView == searchHistoryTableView ? convertHeight(originValue: 56.0) : convertHeight(originValue: 66.0)
        return convertHeight(originValue: 66.0)
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
