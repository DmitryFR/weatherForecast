//
//  AddNewCountry.swift
//  WeatherForecast
//
//  Created by Дмитрий Фролов on 28.03.2018.
//  Copyright © 2018 Дмитрий Фролов. All rights reserved.
//

import UIKit
import CoreData

class AddNewCity: UIViewController {

    @IBOutlet weak var countryInput: UITextField!
    @IBOutlet weak var cityInput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.05, green: 0.31, blue: 0.54, alpha: 1.0)
        countryInput.text = ""
        cityInput.text = ""
    }

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


    @IBAction func saveBtnPressed(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
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
