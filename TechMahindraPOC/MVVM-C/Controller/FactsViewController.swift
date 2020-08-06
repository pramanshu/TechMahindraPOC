//
//  ViewController.swift
//  TechMahindraPOC
//
//  Created by Pramanshu Goel on 07/08/20.
//  Copyright © 2020 Pramanshu Goel. All rights reserved.
//

import UIKit

class FactsViewController: UIViewController {
    
    var facts: FactListModel?
    var factListViewModel :  FactListViewModel?

    let tableView : UITableView = {
          let t = UITableView()
          t.translatesAutoresizingMaskIntoConstraints = false
          return t
      }()
    
    
  
    
    
    
    lazy var refreshControl: UIRefreshControl = {
           let refreshControl = UIRefreshControl()
           refreshControl.addTarget(self, action:
                        #selector(self.handleRefresh(_:)),
                                    for: UIControl.Event.valueChanged)
           refreshControl.tintColor = UIColor.gray
           
           return refreshControl
       }()
    
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {

             refreshControl.endRefreshing()
              self.callGetAPI()
                
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        setUpTable()
     
        self.callGetAPI()
               
              
               

        // Do any additional setup after loading the view.
    }
    func callGetAPI()  {
        if Reachability.shared.isConnectedToNetwork(){

                NetworkService.request(router: .getFacts) { (result:  Result<FactListModel,NetworkError>) in
                          switch result {
                          case .success(let posts):
                              self.facts = posts
                              
                              self.factListViewModel = FactListViewModel(factRow: (self.facts?.rows)!)
                           DispatchQueue.main.async {
                               self.navigationItem.title = self.facts?.title
                               self.tableView.reloadData()
                                                  }
                         case .failure:
                              print("FAILED")
                          }
                      }
               }
               else{
                   let alertController = UIAlertController(title: "", message: "No Internet Found!", preferredStyle: .alert)
                              let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {UIAlertAction in
                              self.tableView.reloadData()
                             }
                              alertController.addAction(okAction)
                              self.present(alertController, animated: true, completion: nil)
               }
    }
    
    func setUpTable(){
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
             tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
             tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
             tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FactTableCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
         tableView.addSubview(self.refreshControl)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension FactsViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FactTableCell else{
                 fatalError("Display Data Cell not found...")
             }
             
        cell.configure(with: (self.factListViewModel?.dataAtIndex(indexPath.row))!)
             return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
      return  factListViewModel?.numbrOfSection ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      return  (factListViewModel?.numberOfRowsinSection(section)) ?? 0
    }
    
    
}
