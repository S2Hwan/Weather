//
//  SearchCityViewController.swift
//  WorldWeather
//
//  Created by S2H on 2018. 5. 23..
//  Copyright © 2018년 S2H. All rights reserved.
//

import UIKit

// 프로토콜 설정
protocol SearchCityDelegate {
    func searchNewCity(city: String)
}

class SearchCityViewController: UIViewController, UITextFieldDelegate {
    
    var delegate : SearchCityDelegate?
    
    @IBOutlet weak var searchCityTextField: UITextField!
    
    override func viewDidLoad() {
        searchCityTextField.returnKeyType = .done // 키보드 return -> done
        searchCityTextField.delegate = self
    }
    
    // 서치버튼 구현
    @IBAction func searchButton(_ sender: UIButton) {
        let cityName = searchCityTextField.text!
        delegate?.searchNewCity(city: cityName)
        self.dismiss(animated: true, completion: nil)
    }
    
    // back 버튼 구현
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 화면 터치로 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // return키로 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchCityTextField {
            searchCityTextField.resignFirstResponder()
        } else {
            
        }
        return true
    }
}
