//
//  TableViewDataSource.swift
//  Spotify-Front
//
//  Created by 송경진 on 2022/11/23.
//

import Foundation

class TableViewDataSource<CellType,Item>:NSObject,UITableViewDataSource where CellType:UITableViewCell {
    let identifier:String
    var items:[Item]
    let configure:(CellType,Item) -> ()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //아이템만큼 반환
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //아이덴티피어에 따라서 셀을 구성함.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as? CellType else { fatalError("\(self.identifier)를 확인해주세요!") }
        //현재 아이템
        let item = self.items[indexPath.row]
        //어떤 셀과 어떤 아이템인지 알려줌
        self.configure(cell,item)
        //셀을 반환
        return cell
    }
    
    func updateDataSource(_ items:[Item]) {
        self.items = items
    }
}
