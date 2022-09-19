//
//  CollectionView.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 16.08.2022.
//

import UIKit

class MainCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var weatherData: WeatherForecastData?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        super.init(frame: .zero, collectionViewLayout: layout)
        
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        
        self.delegate = self
        self.dataSource = self
        register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.reuseId)
        register(MainHeaderCollectionReusableView.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: MainHeaderCollectionReusableView.reuseId)
        
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
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: MainCollectionViewCell.reuseId,
            for: indexPath
        ) as? MainCollectionViewCell else {
            fatalError("DequeueReusableCell failed while casting")
        }
        
        cell.timeLabel.text = convertDateToString(unixDate: weatherData?.hourly[indexPath.row].dt ?? 0, dateFormat: "HH:mm")
        cell.weatherImage.image = UIImage(
            systemName: WeatherImages.iconIDs[(weatherData?.hourly[indexPath.row].weather[0].icon) ?? "50d"] ?? "cloud.bolt.fill")?.withRenderingMode(.alwaysOriginal)
        cell.tempLabel.text = checkTemp(weatherData?.hourly[indexPath.row].temp ?? 0)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: frame.width / 6, height: frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MainHeaderCollectionReusableView.reuseId,
            for: indexPath) as? MainHeaderCollectionReusableView else {
            fatalError("DequeueReusableCell failed while casting")
        }
        header.humidityLabel.text = String(Int(weatherData?.current.humidity ?? 0)) + "%"
        header.windSpeedLabel.text = String(Int(weatherData?.current.windSpeed ?? 0)) + " м/с"
        header.pressureLabel.text = String(Int(weatherData?.current.pressure ?? 0)) + " мм"
        return header
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        CGSize(width: frame.width / 4, height: frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
