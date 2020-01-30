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

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let url = "http://api.weatherstack.com/current"
    let API_KEY = "cc582b9dafedbba713265ccf73342c2f"
    let cities = ["Tomsk", "Paris", "Seattle", "Amsterdam"]
    
    var weatherData = WeatherModel()

    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var cityPicker: UIPickerView!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityPicker.delegate = self
        cityPicker.dataSource = self
    }

    //MARK: - Networking
    func getWeatherData(url: String, params: [String : String]) {
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success! Data has fetched.")
                
                let weatherJSON: JSON = JSON(response.result.value!)
                
                print(weatherJSON)
                
                self.parseJSON(data: weatherJSON)
            } else {
                self.weatherLabel.text = "Connection issues."
            }
        }
        
    }
    
    //MARK: - Parsing data
    func parseJSON(data: JSON) {
        weatherData.cityName = data["location"]["name"].string!
        weatherData.temperature = data["current"]["temperature"].doubleValue
        weatherData.weatherDescriptions = data["current"]["weather_descriptions"][0].string!
        
        updateUI()
    }
    
    //MARK: - Update UI
    func updateUI() {
        weatherLabel.text = String(weatherData.temperature)
        
        switch weatherData.weatherDescriptions {
        case "Mist":
            weatherIcon.image = UIImage(systemName: "cloud.fog")
        case "Sunny":
            weatherIcon.image = UIImage(systemName: "sun.max")
        case "Rain":
            weatherIcon.image = UIImage(systemName: "cloud.rain")
        default:
            weatherIcon.image = UIImage(systemName: "cloud.fill")
        }
    }
    
    //MARK: - UIPickerView Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let parameters = [
            "access_key" : API_KEY,
            "query" : cities[row]
        ]
        
        getWeatherData(url: url, params: parameters)
    }

}

