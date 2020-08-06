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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
         self.callGetAPI()
        // Do any additional setup after loading the view.
    }

    func callGetAPI()  {
           if Reachability.shared.isConnectedToNetwork(){

                   NetworkService.request(router: .getFacts) { (result:  Result<FactListModel,NetworkError>) in
                             switch result {
                             case .success(let posts):
                                 self.facts = posts
                                 
                                
                              DispatchQueue.main.async {
                                  self.navigationItem.title = self.facts?.title
                                 
                                                     }
                            case .failure:
                                 print("FAILED")
                             }
                         }
                  }
                  else{
                      let alertController = UIAlertController(title: "", message: "No Internet Found!", preferredStyle: .alert)
                                 let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {UIAlertAction in
                               
                                }
                                 alertController.addAction(okAction)
                                 self.present(alertController, animated: true, completion: nil)
                  }
       }
}

