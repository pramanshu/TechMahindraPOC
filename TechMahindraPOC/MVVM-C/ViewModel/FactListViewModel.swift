//
//  FactListViewModel.swift
//  TechMahindraPOC
//
//  Created by Pramanshu Goel on 07/08/20.
//  Copyright © 2020 Pramanshu Goel. All rights reserved.
//

import Foundation

struct FactListViewModel {
    
    let factRow :[FactDataModel]
    
}


//MARK: Datasource for Tableview

extension FactListViewModel{
    
    var numbrOfSection:Int{
        return 1
    }
    
    func numberOfRowsinSection(_ section:Int)->Int{
        print(self.factRow.count)
        return  self.factRow.count
    }
    
    func dataAtIndex(_ index:Int)->FactViewModel{
        
        let article = self.factRow[index]
        return FactViewModel(article)
    }
    
}


//MARK: This view model provide info to User intertface

struct FactViewModel {
    
    private let fact:FactDataModel
}

//MARK: Initialize Data View Model

extension FactViewModel{
    
    init(_ data:FactDataModel) {
        self.fact = data
    }
}



//MARK: Initialize Fact View Model properties which are need to show in tableview

extension FactViewModel{
    
    var title:String{
        return self.fact.title ?? "No title Found"
    }
    
    var description:String{
        return self.fact.description ?? "No Description Found"
    }
    
    var imageHref:String{
        return self.fact.imageHref ?? ""
    }
    
}

