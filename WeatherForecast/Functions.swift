//
//  GetWeather.swift
//  WeatherForecast
//
//  Created by Дмитрий Фролов on 31.03.2018.
//  Copyright © 2018 Дмитрий Фролов. All rights reserved.
//

import Foundation

func getWeatherForSelectedCity(city: String, controller: FiveDayWeatherForecastTableViewController) -> Bool{
    var weather: [String:Any]!
    var key = false
    let url = URL(string: "http://api.worldweatheronline.com/premium/v1/weather.ashx?q=\(city)&num_of_days=5&format=json&key=fe53d01a3f3144d481172615182803")!

        let session = URLSession.shared
        session.dataTask(with: url){ (data, response, error) in
            if let response = response{
                print(response)
            }
            guard let data = data else { return }
            print(data)
            
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                //print(json)
                print("here")
                controller.forecast = json!["data"] as! [String: Any]
                controller.tableView.reloadData()
                key = true
            }catch{
                print(error)
            }
            }.resume()
    return key
}


func getWeekdayFromDate(day: String) -> String{
    var weekday: String
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as! TimeZone
    let date = dateFormatter.date(from: day)
    let dayNumber = Calendar.current.component(.weekday, from: date!)
    switch dayNumber {
    case 1:
        weekday = "Sunday"
    case 2:
        weekday = "Monday"
    case 3:
        weekday = "Tuesday"
    case 4:
        weekday = "Wednesday"
    case 5:
        weekday = "Thursday"
    case 6:
        weekday = "Friday"
    case 7:
        weekday = "Saturday"
    default:
        weekday = day
    }
    return weekday
}

