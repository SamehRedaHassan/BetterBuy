//
//  CategoryViewController.swift
//  BetterBuy
//
//  Created by Mohamed Adel on 5/25/22.
//  Copyright © 2022 Mohamed Adel. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController{

    @IBOutlet weak var categoryTableView: UITableView!
    var categories = ["women","men","kids","sale"]
    var categoryViewModel: CategoryViewModelType!
    
    init(categoryViewModel: CategoryViewModelType)
    {
        self.categoryViewModel = categoryViewModel
        super.init(nibName: "CategoryView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
    }
    
    func initTableView(){
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.register(UINib(nibName: "CatoegorieTableViewCell", bundle: nil), forCellReuseIdentifier: CatoegorieTableViewCell.cellIdentifier)
    }

}
extension CategoryViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CatoegorieTableViewCell.cellIdentifier, for: indexPath) as! CatoegorieTableViewCell
        cell.configureCell(categories[indexPath.section].capitalized)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categoryViewModel.navigateToProducts(category: categories[indexPath.section], brand: "all")
    }
    
    
}
extension CategoryViewController : UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return UIScreen.main.bounds.size.height / 5
       }
       
   func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let headerView = UIView()
       headerView.backgroundColor = view.backgroundColor
       return headerView
   }
   func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          return 20
  }
    
    

    
}
