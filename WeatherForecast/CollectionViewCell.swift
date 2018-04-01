//
//  CollectionViewCell.swift
//  WeatherForecast
//
//  Created by Дмитрий Фролов on 01.04.2018.
//  Copyright © 2018 Дмитрий Фролов. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    func  fillCollectionCell(hour: String, image: String, temperature: String){
        self.hourLabel.text = String(Int(hour)!/100) + ":00"
        self.tempLabel.text = temperature + " ˚C"
        
        let filePath = URL(string: image)!
        let session = URLSession(configuration: .default)
        let downloadPic = session.dataTask(with: filePath){(data, response, error) in
            if let res = response as? HTTPURLResponse{
                print("code is \(res.statusCode)")
                if let imageData = data{
                    self.weatherImage.image = UIImage(data: imageData)
                }
            }
            
        }
        downloadPic.resume()
    }
}
