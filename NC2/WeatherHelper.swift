//
//  WeatherHelper.swift
//  NC2
//
//  Created by Belinda Angelica on 22/05/23.
//

import Foundation
import WeatherKit

@MainActor
class WeatherDataHelper: ObservableObject {
  
  static let shared = WeatherDataHelper()
  private let service = WeatherService.shared
  @Published var currentWeather: CurrentWeather?
  
  // TODO
  
}
