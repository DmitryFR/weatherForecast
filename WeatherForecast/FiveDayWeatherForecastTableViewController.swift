//
//  FiveDayWeatherForecastTableViewController.swift
//  WeatherForecast
//
//  Created by Дмитрий Фролов on 31.03.2018.
//  Copyright © 2018 Дмитрий Фролов. All rights reserved.
//

import UIKit
import CoreData

class FiveDayWeatherForecastTableViewController: UITableViewController {
    var selectedCity: NSManagedObject!
    var forecast: [String: Any]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor(red: 0.05, green: 0.31, blue: 0.54, alpha: 1.0)
        self.view.backgroundColor = UIColor(red: 0.05, green: 0.31, blue: 0.54, alpha: 1.0)
        self.title = self.selectedCity.value(forKey: "name") as! String
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let group = DispatchGroup()
        group.enter()
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if (getWeatherForSelectedCity(city: self.selectedCity.value(forKey: "name") as! String, controller: self)){
                DispatchQueue.main.async {
                    group.leave()
                    
                }
            }
            group.notify(queue: .main) {self.tableView.reloadData()}
        }
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.forecast != nil {
             return (self.forecast["weather"] as! NSArray).count
        }
       return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! WeatherTableViewCell
        if (cell == nil){
            cell = WeatherTableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: identifier)
        }
        /// Это вообще ужас :) ты сам через неделю забудешь что здесь за данные и зачем они нужны. Очень тяжело читать, поддерживать, легко допустить ошибки. Вместо хранения словарей заводят классы для модельных объектов с простыми полями (day, imageURL, temp и т.д.), и в эти классы маппят данные из словарей
        let weather = self.forecast["weather"] as! NSArray
        let day = (weather[indexPath.row] as! [String: Any])["date"] as! String
        let image = (((((weather[indexPath.row] as! [String: Any])["hourly"] as! NSArray)[4] as! [String: Any])["weatherIconUrl"] as! NSArray)[0] as! [String:Any])["value"] as! String
        let temp = (((weather[indexPath.row] as! [String: Any])["hourly"] as! NSArray)[4] as! [String: Any])["tempC"] as! String
        let feelings = (((weather[indexPath.row] as! [String: Any])["hourly"] as! NSArray)[4] as! [String: Any])["FeelsLikeC"] as! String
        cell.fillCellFields(day: day, image: image, temperature: temp, feelsLike: feelings)
        cell.backgroundColor = UIColor(red: 0.05, green: 0.31, blue: 0.54, alpha: 1.0)
        return cell
        }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectedDay"{
            let indexPath = self.tableView.indexPathForSelectedRow as! (NSIndexPath)
            /// Тоже очень непонятная и нечитабельная передача данных 
            if  let weather_vc = segue.destination as? HourlyWeatherViewController {
                weather_vc.weather = ((self.forecast["weather"] as! NSArray)[indexPath.row] as! [String: Any])["hourly"] as! NSArray
                weather_vc.date = ((self.forecast["weather"] as! NSArray)[indexPath.row] as! [String:Any])["date"] as! String
            }
        }
    }

}



