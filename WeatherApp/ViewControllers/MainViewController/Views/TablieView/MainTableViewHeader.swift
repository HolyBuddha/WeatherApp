//
//  TableViewHeader.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 11.08.2022.
//

import UIKit

// MARK: - Class

class MainTableViewHeader: UITableViewHeaderFooterView {
    
    // MARK: - Internal properties

    static let reuseID = "TableViewHeader"
    
    // Create UIViews
    private lazy var headerOfTableView = UILabel()
    
    // MARK: - Initializers
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        // Labels Properties
        headerOfTableView.drawLabel(fontSize: 16, weight: .regular, textAligment: .left)
        headerOfTableView.text = "Forecast for 7 days"
        headerOfTableView.translatesAutoresizingMaskIntoConstraints = false
        
        // Added the UI components
        contentView.addSubview(headerOfTableView)
        
        // TableHeader constraits
        NSLayoutConstraint.activate([
            headerOfTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            headerOfTableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -10),
            headerOfTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            headerOfTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
