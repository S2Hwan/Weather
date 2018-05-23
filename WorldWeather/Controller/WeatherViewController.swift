//
//  WeatherViewController.swift
//  WorldWeather
//
//  Created by S2H on 2018. 5. 23..
//  Copyright © 2018년 S2H. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate, SearchCityDelegate {
    
    // open API , key
    let  API_URL = "http://api.openweathermap.org/data/2.5/weather" //forecast
    let KEY = "15ab527164402565820f8a4d70b6ce39"
    
    let locationManager = CLLocationManager()
    let weatherData = WeatherData()
   
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var weatherBgImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 위치 기반 정보
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 위치 정확도 설정 -> kCLLocationAccuracyBest (배터리로 동작시 가장 높은 정확도)
        locationManager.requestWhenInUseAuthorization() // 위치 접근 허가 요청 -> inpo.plist 추가
        locationManager.startUpdatingLocation() // 위치 정보 추적 시작
        
    }
    
    //MARK: - Alamofire Networking
    /***************************************************************/
    // 날씨 정보 가져오기
    func getWeatherData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                
                print("Success! Got the weather data")
                let weatherJSON : JSON = JSON(response.result.value!)
                
                print(weatherJSON)
                
                self.updateWeatherData(json: weatherJSON)
            }
            else {
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
            }
        }
    }
    //MARK: - JSON 파싱
    /***************************************************************/
    // 날씨정보 업데이트
    func updateWeatherData(json : JSON) {
        
        let tempResult = json["main"]["temp"].doubleValue
        
        weatherData.temperature = Int(tempResult - 273.15)
        
        weatherData.city = json["name"].stringValue
        
        weatherData.condition = json["weather"][0]["id"].intValue
        
        weatherData.weatherImageName = weatherData.updateWeatherImage(condition: weatherData.condition)
        
        weatherData.weatherBackgroundImageName = weatherData.updateWeatherBackgroundImage(condition: weatherData.condition)
        
        updateUIWithWeatherData()
    }
    
    //MARK: - UI 설정
    /***************************************************************/
    // 날씨 UI 업데이트
    
    func updateUIWithWeatherData() {
        
        cityLabel.text = weatherData.city
        tempLabel.text = "\(weatherData.temperature)°"
        weatherImage.image = UIImage(named: weatherData.weatherImageName)
        weatherBgImage.image = UIImage(named: weatherData.weatherBackgroundImageName)
    }
    
    //MARK: - 위치 설정
    /***************************************************************/
    // didUpdateLocations 메소드 설정
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            
            self.locationManager.stopUpdatingLocation()
            
            // 경도, 위도 확인
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : KEY]
            
            getWeatherData(url: API_URL, parameters: params)
        }
    }
    
    // didFailWithError 메소드 설정
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "지역을 찾을수 없습니다."
    }
    
    //MARK: - 찾은 도시 업데이트
    /***************************************************************/
    // 찾는 도시 입력해서 api 키값으로 받아오기
    func searchNewCity(city: String) {
        
        let params : [String : String] = ["q" : city, "appid" : KEY]
        
        getWeatherData(url: API_URL, parameters: params)
    }
    
    // PrepareForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSearchVC" {
            let destinationVC = segue.destination as! SearchCityViewController
            destinationVC.delegate = self
        }
    }
}

