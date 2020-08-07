//
//  FactTableCell.swift
//  TechMahindraPOC
//
//  Created by Pramanshu Goel on 07/08/20.
//  Copyright © 2020 Pramanshu Goel. All rights reserved.
//

import Foundation
import UIKit

class FactTableCell: UITableViewCell {
    
    
        //MARK: URLSessionDataTask instance so we can cancel it later
        

    private var dataTask : URLSessionDataTask?
        
        
        
        //MARK: Implementation Image view
        
        let placeImageView:UIImageView = {
            let img = UIImageView()
            img.contentMode = .scaleAspectFill
            img.translatesAutoresizingMaskIntoConstraints = false
            img.layer.cornerRadius = 10
            img.clipsToBounds = true
            return img
        }()
        
        //MARK: Implementation Title label
        
        let titleLabel:UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        //MARK: Implementation Description Label
        
        let descriptionLabel:UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textColor =  .white
            label.clipsToBounds = true
            label.translatesAutoresizingMaskIntoConstraints = false
            
            return label
        }()
        

        //MARk:  Designing of Cell

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            self.contentView.addSubview(placeImageView)
            self.contentView.addSubview(titleLabel)
            self.contentView.addSubview(descriptionLabel)
            
            // configure Image
            placeImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
            placeImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
            placeImageView.widthAnchor.constraint(equalToConstant:60).isActive = true
            placeImageView.heightAnchor.constraint(equalToConstant:60).isActive = true
            
            let marginGuide = contentView.layoutMarginsGuide
            
            // configure Titlelabel
            contentView.addSubview(titleLabel)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.leadingAnchor.constraint(equalTo: placeImageView.leadingAnchor,constant: 100).isActive = true
            titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
            titleLabel.numberOfLines = 0
            titleLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
            
            
            // configure DescriptionLabel
            contentView.addSubview(descriptionLabel)
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.leadingAnchor.constraint(equalTo: placeImageView.leadingAnchor,constant: 100).isActive = true
            descriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
            descriptionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
            descriptionLabel.numberOfLines = 0
            descriptionLabel.font = UIFont(name: "Avenir-Book", size: 14)
            descriptionLabel.textColor = UIColor.lightGray
            
            
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
      
        
        //MARK: Configure Cell
        
    public func configure(with info:FactViewModel,session: URLSession){
            
            self.selectionStyle = .none
            self.titleLabel.text =  info.title
            self.descriptionLabel.text = info.description
            
         let imgUrl = URL(string: info.imageHref)
                   if let imgUrl = imgUrl{
                       
                     
                       // passed session is used for creating data task
                       let dataTask = session.dataTask(with: imgUrl) {[weak self] (data, _, _) in
                           
                           guard let data = data else{
                                DispatchQueue.main.async {
                                    self?.placeImageView.image = UIImage(imageLiteralResourceName: "placeHolderImage")
                               }
                               return
                           }
                          
                           let image = UIImage(data: data)
                           
                           DispatchQueue.main.async {
                               if((image) != nil){
                                self?.placeImageView.image = image
                               }
                               else{
                                self?.placeImageView.image = UIImage(imageLiteralResourceName: "placeHolderImage")
                               }
                           }
                       }
                       self.dataTask = dataTask
                       dataTask.resume()
                   }
                   else{
                        self.placeImageView.image = UIImage(imageLiteralResourceName: "placeHolderImage")
                       
               }
                   

               }
        
        
    
    
    //MARK:  cancelling urlsession task instance while scrolling
    override func prepareForReuse() {
        
        self.dataTask?.cancel()
               dataTask = nil
               self.placeImageView.image = nil
        
    }
        



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
