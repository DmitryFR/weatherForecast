//
//  AddNewCountry.swift
//  WeatherForecast
//
//  Created by Дмитрий Фролов on 28.03.2018.
//  Copyright © 2018 Дмитрий Фролов. All rights reserved.
//

import UIKit
import CoreData

/// Название класса должно отражать его суть. Если он наследуется от view controller, то называться должен AddNewCityViewController
class AddNewCity: UIViewController {

    @IBOutlet weak var countryInput: UITextField!
    @IBOutlet weak var cityInput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.05, green: 0.31, blue: 0.54, alpha: 1.0)
        countryInput.text = ""
        cityInput.text = ""
    }
    
    /// Неправильное именование метода - нет camel case
    func hide_keyboard(){
        print("hide")
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        return textField.resignFirstResponder()
    }
    
    
    func hideKeyboardWhenBackgroundIsTapped(){
        let tgz = UITapGestureRecognizer(target: self, action: Selector("hide_keyboard"))
        tgz.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tgz)
    }

    /// Сохранение данных в хранилище - не задача view controller'a, этим должен заниматься отдельный объект. Ну и в случае ошибки стоит как-то её пользователю отобразить, или крэшнуть приложение, если ошибка серьезная
    @IBAction func saveBtnPressed(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        /// Force unwrap в целом считается плохой практикой, и его стоит избегать. Хотя в данном случае это не критично
        let entity = NSEntityDescription.entity(forEntityName: "City", in: context)!
        let city = NSManagedObject(entity: entity, insertInto: context)
        city.setValue(cityInput.text, forKey: "name")
        city.setValue(countryInput.text, forKey: "country")
        do{
            try context.save()
        }
        catch{
            print("Error while saving new city.")
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    

}
