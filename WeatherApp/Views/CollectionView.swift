//
//  CollectionView.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 16.08.2022.
//

import UIKit

class CollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource,
                      UICollectionViewDelegateFlowLayout  {
    
    private var weatherData : WeatherForecastData?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        super.init(frame: .zero, collectionViewLayout: layout)
        
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        
        
        delegate = self
        dataSource = self
        register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseId)
        register(HeaderCollectionReusableView.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: HeaderCollectionReusableView.reuseId)
        
        backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        layer.cornerRadius = 20
        layer.borderColor = CGColor(gray: 1, alpha: 0.5)
        layer.borderWidth = 1
      
    }
    
    func setData(weatherData: WeatherForecastData) {
        self.weatherData = weatherData
    }
    
    // Configure the CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weatherData?.hourly.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseId, for: indexPath) as! CollectionViewCell
        
        
        cell.timeLabel.text = convertDateToString(unixDate: weatherData?.hourly[indexPath.row].dt ?? 0, dateFormat: "HH:mm")
        cell.weatherImage.image = UIImage(named: weatherData?.hourly[indexPath.row].weather[0].icon ?? "default")
        cell.tempLabel.text = checkTemp(weatherData?.hourly[indexPath.row].temp ?? 0)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: frame.width / 6, height: frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                     withReuseIdentifier: HeaderCollectionReusableView.reuseId,
                                                                     for: indexPath) as! HeaderCollectionReusableView
        header.humidityLabel.text = String(Int(weatherData?.current.humidity ?? 0)) + "%"
        header.windSpeedLabel.text = String(Int(weatherData?.current.windSpeed ?? 0)) + " м/с"
        header.pressureLabel.text = String(Int(weatherData?.current.pressure ?? 0)) + " мм"
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: frame.width / 4, height: frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



