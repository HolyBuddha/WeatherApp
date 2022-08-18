//
//  CollectionView.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 16.08.2022.
//

import UIKit

class CollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource,
                      UICollectionViewDelegateFlowLayout  {
    
    private var weatherData = [WeatherDataList?]()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseId)
        
       
        layout.minimumLineSpacing = 10
        contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setData(weatherData: WeatherForecastData) {
        self.weatherData = weatherData.takeDataFromJSONforDailyForecast()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseId, for: indexPath) as! CollectionViewCell
        collectionView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        collectionView.layer.cornerRadius = 20
        collectionView.layer.borderColor = CGColor(gray: 1, alpha: 0.5)
        collectionView.layer.borderWidth = 1
        
        cell.timeLabel.text = convertDateToString(unixDate: weatherData[indexPath.row]?.dt ?? 0, dateFormat: "HH:mm")
        cell.weatherImage.image = UIImage(named: weatherData[indexPath.row]?.weather[0].icon ?? "default")
        cell.tempLabel.text = checkTemp(weatherData[indexPath.row]?.main.temp ?? 0)
                return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: frame.width/6, height: frame.height-20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
    

