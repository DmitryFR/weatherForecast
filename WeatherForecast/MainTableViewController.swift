//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Дмитрий Фролов on 25.03.2018.
//  Copyright © 2018 Дмитрий Фролов. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController {
    /// А зачем использовать NSArray? Это из Objective-C, в свифте есть тип Array
    var cityArray: NSArray = []
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor(red: 0.05, green: 0.31, blue: 0.54, alpha: 1.0)
        self.view.backgroundColor = UIColor(red: 0.05, green: 0.31, blue: 0.54, alpha: 1.0)
    }
    
    /// Снова коммент про работу с базой из контроллера
    override func viewWillAppear(_ animated: Bool) {
        let context = self.appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "City")
        do{
            self.cityArray = try context.fetch(request) as NSArray
            self.tableView.reloadData()
        }
        catch{
            print("Failed to load data from database")
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as UITableViewCell
        /// Нужно смотреть на варнинги - здесь код избыточный
        if (cell == nil){
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: identifier)
        }
        /// Почему тут force unwrap и такой каст типов к любому объекту? В Swift так не делают, все преимущества типизации языка теряются
        cell.textLabel!.text = (cityArray[indexPath.row] as AnyObject).value(forKey: "name") as! String
        cell.detailTextLabel!.text = (cityArray[indexPath.row] as AnyObject).value(forKey: "country") as! String
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .white
        cell.backgroundColor = UIColor(red: 0.05, green: 0.31, blue: 0.54, alpha: 1.0)
        return cell
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        /// Почему var, если не меняется?
        var context = self.appDelegate.persistentContainer.viewContext
        if editingStyle == .delete{
            /// Здесь приложение крэшится
            context.delete(self.cityArray[indexPath.row] as! NSManagedObject)
            self.cityArray.object(at: indexPath.row)
            do{
                try context.save()
                /// Наименование неверное, нет camel case
                let help_array = NSMutableArray(array: self.cityArray)
                help_array.removeObject(at: indexPath.row)
                self.cityArray = help_array as NSArray
                self.tableView.reloadData()
            }
            catch{
                /// Нет обработки ошибок
                print("Error during removing city")
            }

        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "weatherInfo"){
            /// Зачем кастить к NSIndexPath?
            let indexPath = self.tableView.indexPathForSelectedRow as? (NSIndexPath)
            /// Неверное наименование
            if  let weather_in_city = segue.destination as? FiveDayWeatherForecastTableViewController {
                weather_in_city.selectedCity = self.cityArray[(indexPath?.row)!] as! NSManagedObject
            }
        }
    }
    
    
}

