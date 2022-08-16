//
//  TableViewHeader.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 11.08.2022.
//

import UIKit

class TableViewHeader: UITableViewHeaderFooterView {

    static let reuseID = "TableViewHeader"
    
    // Create UIViews
    private lazy var label = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        // UIView Properties
        label.text = "Прогноз на 5 дней"
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // Added the UI components
        contentView.addSubview(label)
        
        // TableHeader constraits
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -10),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

