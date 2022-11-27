//
//  SearchViewController.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/11.
//

import UIKit
import SnapKit
import RealmSwift
import UIImageColors
class SearchViewController: UIViewController {
    
    // MARK: - Override, Init
    
    override func viewWillAppear(_ bool : Bool){
        super.viewWillAppear(bool)
       updateHistory()
        
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
        
        view.backgroundColor = hexStringToUIColor(hex: "#1A1D1D").withAlphaComponent(0.5)
        view.addSubview(searchFieldView)
        view.addSubview(categoryCollectionView)
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
        
        categoryCollectionView.snp.makeConstraints{ collection in
            collection.left.right.width.equalToSuperview()
            collection.top.equalTo(searchFieldView.snp.bottom).offset(15)
            collection.height.equalTo(35)
            
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
            view.top.equalTo(categoryCollectionView.snp.bottom).offset(convertHeight(originValue: 21.0))
        }
        
        searchHistoryView.snp.makeConstraints{ view in
            view.left.right.bottom.equalToSuperview()
            view.top.equalTo(searchFieldView.snp.bottom).offset(convertHeight(originValue: 8.0))
        }
    }
    
    func setTableView(){
        searchHistoryTableView.dataSource = self
        searchHistoryTableView.delegate = self
        searchHistoryTableView.register(SearchHistoryCell.self, forCellReuseIdentifier: SearchHistoryCell.identifier)
        
        SearchTableView.dataSource = self
        SearchTableView.delegate = self
        SearchTableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
    }
    
    // MARK: - Variable
    
    let realm = try! Realm()
    let tagList = ["최적 검색 결과", "곡","아티스트", "앨범",  "플레이리스트", "팟캐스트 및 프로그램", "프로필"]
    var selected = 0
    var searchList : [Search] = [Search]()
    var histories : [Search] = [Search]()
    let searchHistoryView = {
        let view = UIView()
        view.backgroundColor = hexStringToUIColor(hex: "#121212")
        view.isHidden = false
        return view
    }()
    
    let searchView = {
        let view = UIView()
        view.backgroundColor = hexStringToUIColor(hex: "#191F1F").withAlphaComponent(0.3)
        view.isHidden = true
        return view
    }()
    
    let searchFieldView : UIView = {
        let view = UIView()
        view.backgroundColor = hexStringToUIColor(hex: "#242424").withAlphaComponent(0.3)
//        view.backgroundColor = .clear
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
        label.font = UIFont(name: "Inter-Bold", size: 16)
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
    
    let categoryCollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsMultipleSelection = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - Function
    
    func updateHistory(){
        histories.removeAll()
        let objects = realm.objects(Search.self)
        for i in objects{
            histories.append(i)
        }
        searchHistoryTableView.dataSource = self
        searchHistoryTableView.reloadData()
    }
    
    func search(){
        switch selected {
        case 0 :
            SearchService.shared.search(keyword: searchField.text!){ result in
                switch result {
                case let .success(result):
                    self.searchList = result
                    self.SearchTableView.reloadData()
                case let .failure(error):
                    print(error.localizedDescription)
                }
                
            }
            
        case 1:
            SearchService.shared.music(keyword: searchField.text!){ result in
                switch result {
                case let .success(result):
                    self.searchList = result
                    self.SearchTableView.reloadData()
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            
        case 2 :
            SearchService.shared.artist(keyword: searchField.text!){ result in
                switch result {
                case let .success(result):
                    self.searchList = result
                    self.SearchTableView.reloadData()
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
            
        case 3 :
            SearchService.shared.album(keyword: searchField.text!){ result in
                switch result {
                case let .success(result):
                    self.searchList = result
                    self.SearchTableView.reloadData()
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
      
        default:
            print("error")
            
        }
        
    }
    
    
    @objc func textDidChanged(_sender: Any?){
        if self.searchField.text?.count != 0 {
            initBtn.isHidden = false
            self.searchHistoryView.isHidden = true
            self.searchView.isHidden = false
            switch selected {
            case 0 :
                SearchService.shared.search(keyword: searchField.text!){ result in
                    switch result {
                    case let .success(result):
                        self.searchList = result
                        self.SearchTableView.reloadData()
                    case let .failure(error):
                        print(error.localizedDescription)
                    }
                }
            case 1:
                print("곡")
            case 2:
                print("아티스트")

            case 3:
                print("앨범")

            case 4:
                print("플레이리스트")

            case 5:
                print("팟캐스트 및 프로그램")

            case 6:
                print("프로필")
                
            default:
                print("error")
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
        if tableView == searchHistoryTableView {
            let image = downloadImage(with: "http://localhost:8080" + histories[indexPath.row].image_path){ result in
                switch result {
                case let .success(result):
                    result.getColors(){ color in
                        let vc = AlbumListViewController(data: self.histories[indexPath.row], image: result, color: (color?.secondary.withAlphaComponent(0.5).cgColor)!)
                        
//                        self.navigationController?.show(vc, sender: self)
                        vc.title = self.histories[indexPath.row].name
                        self.navigationController?.pushViewControllerFromLeft(viewControlller: vc)
                        
//                        self.navigationController?.pushViewController(vc, animated: false)
                    }
                   
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
     
        }else{
            print("error")
        }
       
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
            let cell = searchHistoryTableView.dequeueCell(type: SearchHistoryCell.self, indexPath: indexPath)
            cell.selectionStyle = .none
            cell.deleteBtn.tag = indexPath.row
            cell.deleteBtn.addTarget(self, action: #selector(handleRegister(_:)), for: .touchDown)
            
            cell.configure(search: histories[indexPath.row])
            
            
            return cell
        }else{
            let cell = SearchTableView.dequeueCell(type: SearchCell.self, indexPath: indexPath)
            
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
        let cell = contentView?.superview as! SearchCell
                
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
        let cell = contentView?.superview as! SearchHistoryCell
                
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


extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(type: CategoryCell.self, indexPath: indexPath)
        cell.configure(text: tagList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tmpLabel : UILabel = UILabel()

        tmpLabel.text = tagList[indexPath.item]
        tmpLabel.font = UIFont(name: "CircularStd-Book", size: 15)

        return CGSize(width: Int(tmpLabel.intrinsicContentSize.width) + 40, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left:15, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueCell(type: CategoryCell.self, indexPath: indexPath)
        cell.setDeselectedCell()
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selected = indexPath.row
        let cell = collectionView.dequeueCell(type: CategoryCell.self, indexPath: indexPath)
        cell.setSelectedCell()
        self.search()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let selectedCell = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: selectedCell, animated: false, scrollPosition: [])
    }
   
    
    
    
    
}
