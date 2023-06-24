//
//  MenuViewController.swift
//  HummerSys
//
//  Created by Максим Сулим on 22.06.2023.
//

import UIKit

protocol CategoryCollectionProtocol: AnyObject {
    //var controllerCollection: MenuViewController? { get set }
    var categoriesArr: [CategoryProtocol] { get set }
    func reloadCategories(index: Int)
}


class MenuViewController: UIViewController, CategoryCollectionProtocol {
    
    
    func reloadCategories(index: Int) {
        self.categoryCollectionView.reloadData()
        var nameCater = categoriesArr[index].name
        
        if let menuIndex = dataMenu.firstIndex(where: { $0.ctegory.name == nameCater }) {
            scrolNeedIndex(indexRow: menuIndex)
        }
    }
    
    @IBOutlet weak var constrainCategory: NSLayoutConstraint!
    
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var bannerCollection: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
   // отслеживать смещение прокрутки
   fileprivate var scrollOffset: CGPoint = CGPoint()
    
    var categoriesArr = [CategoryProtocol]()
    
    var dataMenu = [MenuProtocol]()
    
    var bannerDel = BannerCollectionViewController()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfigureController()
        loadTable()
        loadCategories()
        bannerDel.loadBanners()
        setupTabbleLayer()
        setupViewLayer()
    }
    
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
    
    func scrolNeedIndex(indexRow: Int) {
        var indexPath = NSIndexPath(row: indexRow, section: 0)
        self.tableView.scrollToRow(at: indexPath as IndexPath,
                                   at: UITableView.ScrollPosition.middle,
                                   animated: true)
    }
    
// MARK: установка начальных данных
    
    private func loadTable() {
        
        dataMenu.append(Menu(ctegory: Category(order: 1, name: CategoryName.pizza, isSelected: true),
                             name: "Ветчина и грибы",
                             description: "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус",
                             image: "pizzaImage",
                             price: "от 320"))
        dataMenu.append(Menu(ctegory: Category(order: 1, name: CategoryName.pizza, isSelected: false),
                             name: "Баварские колбаски",
                             description: "Баварски колбаски,ветчина, пикантная пепперони, острая чоризо, моцарелла, томатный соус",
                             image: "pizzaImage",
                             price: "от 320"))
        dataMenu.append(Menu(ctegory: Category(order: 1, name: CategoryName.pizza, isSelected: false),
                             name: "Нежный лосось",
                             description: "Лосось, томаты черри, моцарелла, соус песто",
                             image: "pizzaImage",
                             price: "от 320"))
        dataMenu.append(Menu(ctegory: Category(order: 1, name: CategoryName.pizza, isSelected: false),
                             name: "Пицца четыре сыра",
                             description: "Соус Карбонара, Сыр Моцарелла, Сыр Пармезан, Сыр Роккфорти, Сыр Чеддер (тёртый)",
                             image: "pizzaImage",
                             price: "от 320"))
        dataMenu.append(Menu(ctegory: Category(order: 2, name: CategoryName.combo, isSelected: false),
                             name: "КОМБО и грибы",
                             description: "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус",
                             image: "pizzaImage",
                             price: "от 450"))
        dataMenu.append(Menu(ctegory: Category(order: 2, name: CategoryName.combo, isSelected: false),
                             name: "КОМБО Баварское",
                             description: "Баварски колбаски,ветчина, пикантная пепперони, острая чоризо, моцарелла, томатный соус",
                             image: "pizzaImage",
                             price: "от 450"))
        dataMenu.append(Menu(ctegory: Category(order: 2, name: CategoryName.combo, isSelected: false),
                             name: "КОМБО Нежный",
                             description: "Лосось, томаты черри, моцарелла, соус песто",
                             image: "pizzaImage",
                             price: "от 450"))
        dataMenu.append(Menu(ctegory: Category(order: 2, name: CategoryName.combo, isSelected: false),
                             name: "КОМБО четыре сыра",
                             description: "Соус Карбонара, Сыр Моцарелла, Сыр Пармезан, Сыр Роккфорти, Сыр Чеддер (тёртый)",
                             image: "pizzaImage",
                             price: "от 450"))
        
       dataMenu = dataMenu.sorted(by: { $0.ctegory.order < $1.ctegory.order})
    }
    
    func loadCategories() {
        categoriesArr.append(Category(order: 1, name: CategoryName.pizza, isSelected: true))
        categoriesArr.append(Category(order: 2, name: CategoryName.combo, isSelected: false))
        categoriesArr.append(Category(order: 3, name: CategoryName.desserts, isSelected: false))
        categoriesArr.append(Category(order: 4, name: CategoryName.drinks, isSelected: false))
    }

    
    
}


//MARK: MenuTable delagate

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuTableViewCell
        cell.nameMenu.text = dataMenu[indexPath.row].name
        cell.descriptionMenu.text = dataMenu[indexPath.row].description
        cell.priceMenu.text = dataMenu[indexPath.row].price
        cell.imageMenu.image = UIImage(named:dataMenu[indexPath.row].image)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        let cellMenu = dataMenu[indexPath.row]
        
        if let categ = categoriesArr.firstIndex(where: { $0.name == cellMenu.ctegory.name }) {
            
            var element = categoriesArr
            
                
                
                for i in 0..<element.count {
                    if element[i].isSelected == true {
                        element[i].isSelected = false
                    }
                }
                
                element[categ].isSelected = true
                categoriesArr = element
                self.categoryCollectionView.reloadData()
        }
        
    }
    
    
}

// MARK: CategoryCollection delegate

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesArr.count
       }
       
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoriesCollectionViewCell
        
         cell.configure(with: CategoriesCollectionViewCell.ViewModel(index: indexPath.row,
                                                                    name: categoriesArr[indexPath.row].name,
                                                                    isSelected: categoriesArr[indexPath.row].isSelected))
        // configureLableCategory(button: cell.categoriBut)
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


