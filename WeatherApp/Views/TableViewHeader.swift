//
//  TableViewHeader.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 11.08.2022.
//

import UIKit

class TableViewHeader: UITableViewHeaderFooterView {

    static let identifier = "tableHeader"
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Прогноз на 5 дней"
        label.textAlignment = .center
        label.textColor = .white
        //label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
        label.frame = CGRect(x: 0, y: contentView.frame.size.height-10-label.frame.size.height, width: contentView.frame.size.width, height: label.frame.size.height)
    }
}

