//
//  ViewController.swift
//  WSWeather
//
//  Created by Evgeniy on 23.01.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let apiService = ApiService()

    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var cityPicker: UIPickerView! {
        didSet {
            cityPicker.delegate = self
            cityPicker.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - Update UI
    func updateUI(_ data: WeatherModel) {
        let result = String(data.current.temperature)
        weatherLabel.text = result
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
        
        apiService.getWeatherByCity(parameters: parameters) { result in
            switch result {
            case .success(let data):
                self.updateUI(data)
            case .failure(let error):
                print(error)
            }
        }
        
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

