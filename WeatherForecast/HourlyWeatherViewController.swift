//
//  HourlyWeatherViewController.swift
//  WeatherForecast
//
//  Created by Дмитрий Фролов on 01.04.2018.
//  Copyright © 2018 Дмитрий Фролов. All rights reserved.
//

import UIKit

class HourlyWeatherViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    var weather: NSArray!
    var date: String!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weather.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
        let hour = (self.weather[indexPath.row] as! [String:Any])["time"] as! String
        let image = (((self.weather[indexPath.row] as! [String:Any])["weatherIconUrl"] as! NSArray)[0] as! [String:Any])["value"] as! String
        let temp = (self.weather[indexPath.row] as! [String:Any])["tempC"] as! String
        cell.fillCollectionCell(hour: hour, image: image, temperature: temp)
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.05, green: 0.31, blue: 0.54, alpha: 1.0)
        self.collectionView.backgroundColor = UIColor(red: 0.05, green: 0.31, blue: 0.54, alpha: 1.0)
        self.title = getWeekdayFromDate(day: date)
    }

    
}
