//
//  ViewController.swift
//  WSWeather
//
//  Created by Evgeniy on 23.01.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    var weatherData = WeatherModel.init(cityName: "", temperature: 0)

    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var cityPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityPicker.delegate = self
        cityPicker.dataSource = self
    }

    //MARK: - Networking
    func getWeatherData(url: String, params: [String : String]) {
        AF.request(Constants.url, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .success(let data):
                let json: JSON = JSON(data)
                self.parseJSON(json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - Parsing data
    func parseJSON(_ data: JSON) {
        weatherData.cityName = data["location"]["name"].string!
        weatherData.temperature = data["current"]["temperature"].doubleValue
        
        updateUI()
    }
    
    //MARK: - Update UI
    func updateUI() {
        weatherLabel.text = String(weatherData.temperature)
    }

}

//MARK: - UIPickerView Delegate
extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Constants.cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let parameters = [
            "access_key" : Constants.API_KEY,
            "query" : Constants.cities[row]
        ]
        
        getWeatherData(url: Constants.url, params: parameters)
    }
    
}

//MARK: - UIPickerView DataSource
extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.cities.count
    }
    
}

