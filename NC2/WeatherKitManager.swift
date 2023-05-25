//
//  WeatherKitManager.swift
//  NC2
//
//  Created by Belinda Angelica on 22/05/23.
//

import Foundation
import WeatherKit
import CoreLocation

@MainActor class WeatherKitHelper: ObservableObject {
    @Published var currentWeather: CurrentWeather?
}

@MainActor class WeatherKitManager: ObservableObject {
    
    static let shared = WeatherDataHelper()
    private let service = WeatherService.shared
    @Published var weather: Weather?
    @Published var currentWeather: CurrentWeather?

    
    var currentDate: Date
    
    init(currentDate: Date) {
        self.currentDate = currentDate
    }
    
    func getWeather(latitude: Double, longitude: Double) async {
        do {
            weather = try await Task.detached(priority: .userInitiated) {
                return try await WeatherService.shared.weather(for: .init(latitude: latitude, longitude: longitude))
            }.value
        } catch {
            fatalError("\(error)")
        }
    }
    func updateCurrentWeather(userLocation: CLLocation) {
        Task.detached(priority: .userInitiated) {
            do {
                let forcast = try await self.service.weather(
                    for: userLocation,
                    including: .current)
                DispatchQueue.main.async {
                    self.currentWeather = forcast
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    var symbol: String {
        weather?.currentWeather.symbolName ?? "xmark"
    }
    
    var temp: String {
        let temp =
        weather?.currentWeather.temperature
        
        let convert = temp?.converted(to: .fahrenheit).description
        return convert ?? "Loading Weather Data"
        
    }
    
}
