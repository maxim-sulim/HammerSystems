//
//  MenuViewController.swift
//  HummerSys
//
//  Created by Максим Сулим on 22.06.2023.
//

import UIKit

class MenuViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataMenu = [MenuProtocol]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTable()
       // self.tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    
    private func loadTable() {
        
        dataMenu.append(Menu(name: "Ветчина и грибы",
                             description: "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус",
                             image: "",
                             price: "от 320"))
        dataMenu.append(Menu(name: "Баварские колбаски",
                             description: "Баварски колбаски,ветчина, пикантная пепперони, острая чоризо, моцарелла, томатный соус",
                             image: "",
                             price: "от 320"))
        dataMenu.append(Menu(name: "Нежный лосось",
                             description: "Лосось, томаты черри, моцарелла, соус песто",
                             image: "",
                             price: "от 320"))
        dataMenu.append(Menu(name: "Пицца четыре сыра",
                             description: "Соус Карбонара, Сыр Моцарелла, Сыр Пармезан, Сыр Роккфорти, Сыр Чеддер (тёртый)",
                             image: "",
                             price: "от 320"))
    }
    
    
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuTableViewCell
        cell.nameMenu.text = dataMenu[indexPath.row].name
        cell.descriptionMenu.text = dataMenu[indexPath.row].description
        cell.priceMenu.text = dataMenu[indexPath.row].price
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156
    }
    
    
}

