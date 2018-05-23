//
//  WeatherData.swift
//  WorldWeather
//
//  Created by S2H on 2018. 5. 23..
//  Copyright © 2018년 S2H. All rights reserved.
//

import UIKit

class WeatherData {
    
    // 날씨 데이터 모델
    var temperature : Int = 0
    var condition : Int = 0
    var city : String = ""
    var weatherImageName : String = ""
    var weatherBackgroundImageName : String = ""
    
    
    // 날씨 아이콘 이미지
    func updateWeatherImage(condition: Int) -> String {
        
        switch (condition) {
            
        case 0...300 :
            return "storm1" //
            
        case 301...500 :
            return "light rain" //
            
        case 501...600 :
            return "heavy rain" //
            
        case 601...700 :
            return "snow" //
            
        case 701...771 :
            return "fog" //
            
        case 772...799 :
            return "storm2" //
            
        case 800 :
            return "sunny" //
            
        case 801...804 :
            return "clouds" //
            
        case 900...903, 905...1000  :
            return "storm2" //
            
        case 903 :
            return "snow2" //
            
        case 904 :
            return "sunny" //
            
        default :
            return "question" //
        }
        
    }
    
    // 날씨 배경 이미지
    func updateWeatherBackgroundImage(condition: Int) -> String {
        
        switch (condition) {
        case 0...300 :
            return "rainbg" //
            
        case 301...500 :
            return "rainbg" //
            
        case 501...600 :
            return "rainbg" //
            
        case 601...700 :
            return "snowbg" //
            
        case 701...771 :
            return "fogbg" //
            
        case 772...799 :
            return "rainbg" //
            
        case 800 :
            return "sunnybg" //
            
        case 801...804 :
            return "cloudbg" //
            
        case 900...903, 905...1000  :
            return "rainbg" //
            
        case 903 :
            return "snowbg" //
            
        case 904 :
            return "sunnybg" //
            
        default :
            return "mainbg" //
        }
    }
}
