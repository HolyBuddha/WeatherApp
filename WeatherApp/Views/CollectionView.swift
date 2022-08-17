//
//  CollectionView.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 16.08.2022.
//

import UIKit

class CollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource,
                      UICollectionViewDelegateFlowLayout  {
    
    var weatherData: WeatherForecastData?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseId)
        
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = 10
        contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseId, for: indexPath) as! CollectionViewCell
        collectionView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        collectionView.layer.cornerRadius = 20
        collectionView.layer.borderColor = CGColor(gray: 1, alpha: 0.5)
        collectionView.layer.borderWidth = 1
        collectionView.drawShadow()
        cell.timeLabel.text = "Hello"
        cell.weatherImage.image = UIImage(systemName: "sun.min")
        cell.tempLabel.text = "23"
                return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: frame.width/6, height: frame.height-20)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
    

