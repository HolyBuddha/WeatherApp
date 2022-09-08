//
//  SettingsVIewControllerViewController.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 08.09.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private lazy var stackView: UIStackView = {
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
    
    private lazy var segmentForTemperature: UISegmentedControl = {
        
        let segmentForTemperature = UISegmentedControl(items: ["C" , "F"])
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
    
    private lazy var labelForSwitchTemperature: UILabel = {
       let labelForSwitchTemperature = UILabel()
        labelForSwitchTemperature.text = "Температура"
        labelForSwitchTemperature.drawLabel(fontSize: 20, weight: .medium)
        labelForSwitchTemperature.textAlignment = .left
        labelForSwitchTemperature.textColor = .white
        return labelForSwitchTemperature
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSubviews(stackView)
        setConstraits()
    }
    
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    private func setConstraits() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            stackView.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.size.height / 14),
        ])
    }
    private func setupNavigationBar() {
    
        title = "Настройки"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.view.backgroundColor = .clear
    }
    @objc private func valueChanged(segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0: print( "Цельсий!")
        case 1: print("Фаренгейт!")
        default: break
        }
    }
    }
