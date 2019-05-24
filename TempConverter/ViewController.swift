//
//  ViewController.swift
//  TempConverter
//
//  Created by MacBook on 5/22/19.
//  Copyright © 2019 Apptive. All rights reserved.
//

import UIKit

enum TemperatureType {
    case fahrenheit
    case celsius
}

class ViewController: UIViewController {
    

    let titleLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Temp Converter"
        title.font = UIFont.systemFont(ofSize: 40, weight: .black)
        return title
    }()
    
    let descriptionLabel: UILabel = {
        let description = UILabel()
        description.textAlignment = .center
        description.numberOfLines = 2
        description.translatesAutoresizingMaskIntoConstraints = false
        let atributedtext = NSMutableAttributedString(string: "convert temperature from", attributes:[ NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        atributedtext.append(NSAttributedString(string: " fahrenheit", attributes: [NSAttributedString.Key.foregroundColor:UIColor.black]))
        atributedtext.append(NSAttributedString(string: " to Celsius or", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        atributedtext.append(NSAttributedString(string: " Celsius", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]))
        atributedtext.append(NSAttributedString(string: " to fahrenheit", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        
        description.attributedText = atributedtext
        description.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return description
    }()
    
    let tempTextField:UITextField = {
        let temp = UITextField()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.placeholder = "Enter Temperature"
        temp.textAlignment = .center
        temp.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        temp.keyboardType = .numberPad
        return temp
    }()
    
    let convertButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("Convert", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .blue
        btn.addTarget(self, action: #selector(convertTemperature), for: .touchUpInside)
        return btn
    }()
    
    lazy var stackView:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [tempTextField,convertButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    let fahrenheitBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Fahrenheit", for: .normal)
        btn.addTarget(self, action: #selector(convertToFahrenheit), for: .touchUpInside)
        btn.isSelectedColor()
        return btn
    }()
    
    let celciusBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Celsius", for: .normal)
        btn.addTarget(self, action: #selector(convertToCelcius), for: .touchUpInside)
        btn.unSelectedColor()
        return btn
    }()
    
    lazy var stackView2:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [fahrenheitBtn,celciusBtn])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    var temperatureType : TemperatureType = .fahrenheit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }

    // MARK: - CONSTRAINTS
    fileprivate func configureViews(){
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
        ])
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
            
            convertButton.heightAnchor.constraint(equalToConstant: 50),
            tempTextField.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
        view.addSubview(stackView2)
        NSLayoutConstraint.activate([
            stackView2.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            stackView2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            fahrenheitBtn.heightAnchor.constraint(equalToConstant: 50),
            celciusBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: stackView2.bottomAnchor, constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 40)
        ])
    }
    
    // MARK: - SELECTORS
    @objc fileprivate func convertTemperature(){
        convertor(type: temperatureType)
        animateButtonForSelection(convertButton)
    }
    
    @objc fileprivate func convertToFahrenheit() {
        fahrenheitBtn.isSelectedColor()
        celciusBtn.unSelectedColor()
        animateButtonForSelection(fahrenheitBtn)
        temperatureType = .fahrenheit
        
    }
    
    @objc fileprivate func convertToCelcius() {
        celciusBtn.isSelectedColor()
        fahrenheitBtn.unSelectedColor()
        animateButtonForSelection(celciusBtn)
        temperatureType = .celsius
    }
    
    fileprivate func convertingToFahrenheit(temp:Double){
        let temperature = temp * 1.8 + 32
        let fahrenheit = Int(temperature)
        titleLabel.text = "\(fahrenheit)℉"
        tempTextField.text = ""
    }
    
    fileprivate func convertingToCelsius(temp:Double){
        let celsius  = (temp - 32) * 5/9
        let temperature = Int(celsius)
        titleLabel.text = "\(temperature)℃"
        tempTextField.text = ""
    }
    
    fileprivate func convertor(type:TemperatureType){
        guard let temperature = Double(tempTextField.text!) else { return}

        switch type {
        case .fahrenheit:
            convertingToFahrenheit(temp: temperature)
            print("this is fahrenheit")
        case .celsius:
            convertingToCelsius(temp: temperature)
            print("this is celsius")
        }
    }

    func animateButtonForSelection(_ button: UIButton){
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (_) in
            button.transform = .identity
        }
    }
}

