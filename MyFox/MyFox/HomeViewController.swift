//
//  HomeViewController.swift
//  MyFox
//
//  Created by Chris on 4/7/17.
//  Copyright © 2017 RMIT. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var homeViewModel = HomeViewModel()
    var disposableBag = DisposeBag()
    
    var categoris: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        bindViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func bindViewModel() {
        homeViewModel.categoriesObservable.asObservable().subscribe(onNext: { categories in
            self.categoris = categories
            self.tableView.reloadData()
        }).addDisposableTo(disposableBag)
        homeViewModel.fetchHomePageContent()
    }

}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoris.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategoryCell
        cell.loadData(withCategory: categoris[indexPath.row])
        return cell
    }
}
