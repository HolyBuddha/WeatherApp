//
//  SettingsVIewControllerViewController.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 08.09.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var onClose: ((TemperatureType) -> Void)?
    
    private lazy var stackViewForTemp: UIStackView = {
        var stackView = UIStackView()
        stackView = UIStackView(arrangedSubviews: [
            labelForSwitchTemperature,
            segmentForTemperature
        ])
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var stackViewForWindSpeed: UIStackView = {
        var stackView = UIStackView()
        stackView = UIStackView(arrangedSubviews: [
            labelForWindSpeed,
            segmentForWindSpeed
        ])
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var labelForWindSpeed: UILabel = {
       let labelForWindSpeed = UILabel()
        labelForWindSpeed.text = "Скорость ветра"
        labelForWindSpeed.drawLabel(fontSize: 20, weight: .medium)
        labelForWindSpeed.textAlignment = .left
        labelForWindSpeed.textColor = .white
        return labelForWindSpeed
    }()
    
    private lazy var labelForSwitchTemperature: UILabel = {
       let labelForSwitchTemperature = UILabel()
        labelForSwitchTemperature.text = "Температура"
        labelForSwitchTemperature.drawLabel(fontSize: 20, weight: .medium)
        labelForSwitchTemperature.textAlignment = .left
        labelForSwitchTemperature.textColor = .white
        return labelForSwitchTemperature
    }()
    
    private lazy var segmentForWindSpeed: UISegmentedControl = {
        let segmentForWindSpeed = UISegmentedControl(items: ["м/с", "км/с"])
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let titleTextAttributesSelected = [NSAttributedString.Key.foregroundColor: UIColor.black]
        segmentForWindSpeed.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentForWindSpeed.setTitleTextAttributes(titleTextAttributesSelected, for: .selected)
        
        segmentForWindSpeed.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        segmentForWindSpeed.layer.borderWidth = 1
        segmentForWindSpeed.layer.borderColor = CGColor(gray: 1, alpha: 1)
        
        segmentForWindSpeed.addTarget(self, action: #selector(valueChanged(segmentedControl:)), for: .valueChanged)
        segmentForWindSpeed.selectedSegmentIndex = 0
        
        return segmentForWindSpeed
    }()
    
    lazy var segmentForTemperature: UISegmentedControl = {
        
        let segmentForTemperature = UISegmentedControl(items: ["C", "F"])
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let titleTextAttributesSelected = [NSAttributedString.Key.foregroundColor: UIColor.black]
        segmentForTemperature.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentForTemperature.setTitleTextAttributes(titleTextAttributesSelected, for: .selected)
        
        segmentForTemperature.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        segmentForTemperature.layer.borderWidth = 1
        segmentForTemperature.layer.borderColor = CGColor(gray: 1, alpha: 1)
        
        segmentForTemperature.addTarget(self, action: #selector(valueChanged(segmentedControl:)), for: .valueChanged)
        segmentForTemperature.selectedSegmentIndex = 0
        
        return segmentForTemperature
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSubviews(stackViewForTemp, stackViewForWindSpeed)
        setConstraits()
        view.backgroundColor = .black
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if segmentForTemperature.selectedSegmentIndex == 0 {
            onClose?(.celsius)
        } else {
            onClose?(.fahrenheit)
        }
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    private func setConstraits() {
        stackViewForTemp.translatesAutoresizingMaskIntoConstraints = false
        stackViewForWindSpeed.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            stackViewForTemp.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackViewForTemp.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            stackViewForTemp.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.size.height / 14),
            
            stackViewForWindSpeed.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackViewForWindSpeed.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            stackViewForWindSpeed.topAnchor.constraint(equalTo: stackViewForTemp.bottomAnchor, constant: 20)
        ])
    }
    private func setupNavigationBar() {
    
        title = "Настройки"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.view.backgroundColor = .clear
    }
    @objc private func valueChanged(segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0: WeatherApi.shared.units = .metric
        case 1: WeatherApi.shared.units = .imperial
        default: break
        }
    }
    }
