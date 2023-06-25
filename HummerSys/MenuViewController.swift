//
//  MenuViewController.swift
//  HummerSys
//
//  Created by Максим Сулим on 22.06.2023.
//

import UIKit
import Foundation

protocol CategoryCollectionProtocol: AnyObject {
    var categoriesArrCustomer: [Category] { get set }
    func reloadCategories(index: Int)
}


class MenuViewController: UIViewController, CategoryCollectionProtocol {
    
    
    @IBOutlet weak var constrainCategory: NSLayoutConstraint!
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var bannerCollection: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    // отслеживать смещение прокрутки
    fileprivate var scrollOffset: CGPoint = CGPoint()
    
    
    var categoriesArrCustomer = [Category]()
    
    
    var dataMenuCustomer = [ArrItem]()
    
    var bannerDel = BannerCollectionViewController()
    //количество запросов к Api
    let requestCount = 28
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadCategories()
        setupConfigureController()
        bannerDel.loadBanners()
        setupTabbleLayer()
        setupViewLayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if dataMenuCustomer.isEmpty {
            self.loadDataMenu()
        }
    }
  
    //MARK: Configure
    
    func setupConfigureController() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.dataSource = self
        self.bannerCollection.dataSource = bannerDel
        self.bannerCollection.delegate = bannerDel
    }
    
    func setupConfigurCategoriesShadow() {
        
        
        self.categoryCollectionView.layer.shadowColor = UIColor.gray.withAlphaComponent(0.4).cgColor
        self.categoryCollectionView.layer.shadowOffset = CGSizeMake(0, 30)
        self.categoryCollectionView.layer.shadowRadius = 15
        self.categoryCollectionView.layer.shadowOpacity = 1
        self.categoryCollectionView.clipsToBounds = false
        self.categoryCollectionView.layer.masksToBounds = false
        
    }
    
    func setupTabbleLayer() {
        self.tableView.layer.cornerRadius = 20
    }
    
    func setupViewLayer() {
        self.view.layer.backgroundColor = Resources.Color.backgroungView.cgColor
        self.categoryCollectionView.layer.backgroundColor = Resources.Color.backgroungView.cgColor
        self.bannerCollection.layer.backgroundColor = Resources.Color.backgroungView.cgColor
    }
    
    func reloadCategories(index: Int) {
        self.categoryCollectionView.reloadData()
        let nameCater = categoriesArrCustomer[index].name
        
        if let menuIndex = dataMenuCustomer.firstIndex(where: { $0.category.name == nameCater }) {
            scrolNeedIndex(indexRow: menuIndex)
        }
    }
    
    func scrolNeedIndex(indexRow: Int) {
        let indexPath = NSIndexPath(row: indexRow, section: 0)
        self.tableView.scrollToRow(at: indexPath as IndexPath,
                                   at: UITableView.ScrollPosition.middle,
                                   animated: true)
    }
    
    // MARK: установка начальных данных
    
    func loadCategories() {
        categoriesArrCustomer.append(Category(order: "1", name: CategoryName.pizza, isSelected: true))
        categoriesArrCustomer.append(Category(order: "2", name: CategoryName.combo, isSelected: false))
        categoriesArrCustomer.append(Category(order: "3", name: CategoryName.desserts, isSelected: false))
        categoriesArrCustomer.append(Category(order: "4", name: CategoryName.drinks, isSelected: false))
    }
    
    //MARK: установка категорий для прдметов меню и их сортировка
    func sortedArrMenu() {
        for i in 0..<dataMenuCustomer.count{
            if dataMenuCustomer[i].category.name == CategoryName.pizza {
                dataMenuCustomer[i].category.order = "1"
            } else if dataMenuCustomer[i].category.name == CategoryName.combo {
                dataMenuCustomer[i].category.order = "2"
            } else if dataMenuCustomer[i].category.name == CategoryName.desserts {
                dataMenuCustomer[i].category.order = "3"
            } else if dataMenuCustomer[i].category.name == CategoryName.drinks {
                dataMenuCustomer[i].category.order = "4"
            }
        }
        let sortMenu = self.dataMenuCustomer.sorted(by: { Int($0.category.order) ?? 0
            < Int($1.category.order) ?? 1 })
        
        self.dataMenuCustomer = sortMenu
    }
    
    
    //MARK: Работа с сетью
    func loadDataMenu() {
        
        let strUrl = "https://randomapi.com/api/4tx32fdb?key=0USK-03CB-VLOM-BWJE"
        let url = URL(string: strUrl)!
        let urlRequest = URLRequest(url: url)
        
        
        for _ in 0..<self.requestCount {
            
            URLSession.shared.dataTask(with: urlRequest) { data , response , error in
                
                guard let data = data else {
                    return }
                
                if let arrJs = try? JSONDecoder().decode(Welcome.self, from: data) {
                    
                    let arrItems = arrJs.results
                    self.dataMenuCustomer.append(contentsOf: (arrItems.first?.customer.arrItem)!)
                    
                    DispatchQueue.main.async {
                        
                        self.tableView.reloadData()
                    }
                }
            }.resume()
        }
        
    }
    
}


//MARK: MenuTable delagate

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataMenuCustomer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuTableViewCell
        
        if dataMenuCustomer.count >= 3  {
            
            sortedArrMenu()
            cell.nameMenu.text = dataMenuCustomer[indexPath.row].name
            cell.descriptionMenu.text = dataMenuCustomer[indexPath.row].description
            if dataMenuCustomer[indexPath.row].category.name == CategoryName.pizza  {
                cell.priceMenu.text = "от 380"
                cell.imageMenu.image = UIImage(named:"pizzaImage")
            } else if dataMenuCustomer[indexPath.row].category.name == CategoryName.combo {
                cell.priceMenu.text = "от 490"
                cell.imageMenu.image = UIImage(named:"comboImage")
            } else if dataMenuCustomer[indexPath.row].category.name == CategoryName.drinks {
                cell.priceMenu.text = "от 550"
                cell.imageMenu.image = UIImage(named:"drinksImage")
            } else {
                cell.priceMenu.text = "от 580"
                cell.imageMenu.image = UIImage(named:"dessertsImage")
            }
            
            
        } else if dataMenuCustomer.count < 3 {
            
            cell.nameMenu.text = "Секунду пожалуйста!"
            cell.descriptionMenu.text = "Простите"
            cell.priceMenu.text = "от 380"
            cell.imageMenu.image = UIImage(named:"pizzaImage")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156
    }
   
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        let cellMenu = dataMenuCustomer[indexPath.row]
        
        if let categ = categoriesArrCustomer.firstIndex(where: { $0.name == cellMenu.category.name }) {
            
            var element = categoriesArrCustomer
            
                
                for i in 0..<element.count {
                    if element[i].isSelected == true {
                        element[i].isSelected = false
                    }
                }
                
                element[categ].isSelected = true
                categoriesArrCustomer = element
                self.categoryCollectionView.reloadData()
        }
        
    }
    
    
}

// MARK: CategoryCollection delegate

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesArrCustomer.count
       }
       
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoriesCollectionViewCell
        
         cell.configure(with: CategoriesCollectionViewCell.ViewModel(index: indexPath.row,
                                                                    name: categoriesArrCustomer[indexPath.row].name,
                                                                    isSelected: categoriesArrCustomer[indexPath.row].isSelected))
        
         cell.delegate = self
         
          return cell
        
       }
    
}

//MARK: Scroll work

extension MenuViewController: UIScrollViewDelegate {
    
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let _: CGPoint = CGPoint(x: scrollView.contentOffset.x,
                                     y: scrollView.contentOffset.y)
        
        if  scrollView.contentOffset.y > 0 {
            setupConfigurCategoriesShadow()
            self.bannerCollection.isHidden = true
            self.constrainCategory.constant = 10
            UIView.animate(withDuration: 0.5, delay: 0.1) {
                self.view.layoutIfNeeded()
            }
            
        } else {
            self.categoryCollectionView.layer.shadowOpacity = 0
            self.bannerCollection.isHidden = false
            self.constrainCategory.constant = 200
            UIView.animate(withDuration: 0.5, delay: 0.1) {
                self.view.layoutIfNeeded()
            }
        }
        scrollOffset = scrollView.contentOffset
    }
    
}


