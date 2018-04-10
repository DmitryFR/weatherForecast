//
//  WeatherTableViewCell.swift
//  WeatherForecast
//
//  Created by Дмитрий Фролов on 31.03.2018.
//  Copyright © 2018 Дмитрий Фролов. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    

    func fillCellFields(day: String, image: String, temperature: String, feelsLike: String){
        
        self.feelsLikeLabel.text = feelsLike
        self.temperatureLabel.text = temperature
        /// Тут опять коммент про неявную зависимость, про название image и про force unwrap
        self.weekDayLabel.text = getWeekdayFromDate(day: day)
        let filePath = URL(string: image)!
        let session = URLSession(configuration: .default)
        let downloadPic = session.dataTask(with: filePath){(data, response, error) in
            if let res = response as? HTTPURLResponse{
                print("code is \(res.statusCode)")
                /// Нужно вернуться в главный поток
                if let imageData = data{
                    self.weatherImage.image = UIImage(data: imageData)
                }
            }
            
        }
        downloadPic.resume()
    }

}
