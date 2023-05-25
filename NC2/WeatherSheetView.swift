//
//  WeatherSheetView.swift
//  NC2
//
//  Created by Belinda Angelica on 22/05/23.
//

import SwiftUI
import WeatherKit
import MapKit
import CoreLocation

struct WeatherSheetView: View {
    @State var currentDate = Date()
    @Binding var pikLoc: String
    @Binding var pikLocloc: String
    
    
    var body: some View {
        ZStack {
            VStack {
                Capsule()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 50, height: 5)
                    .padding(.top)
                    .padding(.bottom)
                
                VStack (alignment: .leading) {
                    HStack {
                        Text("\(pikLoc)")
                            .bold()
                            .font(.system(size: 30))
                        Spacer()
                        NavigationLink(destination: SheetView(pikLoc: $pikLoc, pikLocloc: $pikLocloc)) {
                            Image(systemName: "x.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Text("\(pikLocloc)")
                        .font(.system(size: 21))
                    
                    Divider()
                    HStack {
                        Text("Set Your Arrival Time")
                            .bold()
                            .padding(.top)
                            .padding(.bottom)
                            .font(.system(size: 18))
                        Spacer()
                        DatePicker("", selection: $currentDate, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .padding(.top)
                            .padding(.bottom)
                    }
                    Divider()
                    
                    Text("Weather Conditions")
                        .bold()
                        .padding(.top)
                        .padding(.bottom, 1)
                        .font(.system(size: 18))
                    Text("Below is the weather predictions by the time your arrive at your destination.")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                        .padding(.bottom,1)
                    AnyView(getDesciption())
                    
                    
                    ScrollView {
                        AnyView(getWeather())
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Spacer()
                Divider()
                    .hidden()
                
            }
        }
        .padding(.vertical,10)
        .padding(.horizontal,20)
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(15)
        .edgesIgnoringSafeArea(.bottom)
    }
    
    func getDesciption() -> any View {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        
        if let hour = Int(formatter.string(from: currentDate)) {
            switch hour {
            case 0..<3:
                return AnyView( VStack (alignment: .leading) {
                    Text("Beware that this area will have ") +
                    Text("low road visibility & high chance of  ").bold() +
                    Text("by the time you arrive.")
                }
                )
               
            case 3..<6:
                return AnyView( VStack (alignment: .leading) {
                    Text("This area will get ") +
                    Text("muddy & slippery ").bold() +
                    Text("by the time you arrive.")
                }
                )
                
            case 6..<9:
                return AnyView( VStack (alignment: .leading) {
                    Text("This area might get ") +
                    Text("slippery ").bold() +
                    Text("by the time you arrive.")
                }
                )
                
            case 9..<12:
                return AnyView( VStack (alignment: .leading) {
                    Text("This area will have ") +
                    Text("warm temperature ").bold() +
                    Text("by the time you arrive.")
                }
                )
                
            case 12..<15:
                return AnyView( VStack (alignment: .leading) {
                    Text("This area will have ") +
                    Text("hot temperature ").bold() +
                    Text("by the time you arrive.")
                }
                )
                
            case 15..<18:
                return AnyView( VStack (alignment: .leading) {
                    Text("This area will be ") +
                    Text("warm & covered by clouds ").bold() +
                    Text("by the time you arrive.")
                }
                )
                
            case 18..<21:
                return AnyView( VStack (alignment: .leading) {
                    Text("This area will have ") +
                    Text("fogs & cloudy sky ").bold() +
                    Text("by the time you arrive.")
                }
                )
                
            case 21..<24:
                return AnyView( VStack (alignment: .leading) {
                    Text("This area will be ") +
                    Text("covered by clouds & have temperature drop ").bold() +
                    Text("by the time you arrive.")
                }
                )
                
            default:
                print("pogihajima")
                return AnyView(VStack{Text("")})
                
            }
        }   else {
            print("nonono")
            return AnyView(VStack{Text("")})
        }
    }
    
    func getWeather() -> any View {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        
        if let hour = Int(formatter.string(from: currentDate)) {
            switch hour {
            case 0..<3:
                return AnyView( VStack{
                    HStack {
                        Spacer()
                        VStack {
                            Image(systemName: "cloud.bolt.rain.fill")
                                .foregroundColor(.gray)
                                .font(.system(size: 48))
                                .padding()
                            Text("Thunderstorm")
                                .font(.system(size: 18))
                                .padding(.bottom)
                            
                        }
                        Spacer()
                        Divider()
                            .frame(height: 150)
                        Spacer()
                        VStack (alignment: .leading) {
                            Text("\(pikLocloc)")
                                .padding(.bottom, 1)
                                .font(.system(size: 18))
                                .bold()
                            Text("27°")
                                .padding(.top, 5)
                                .font(.system(size: 48))
                                .fontWeight(.thin)
                        }
                        Spacer()
                    }
                    HStack{
                        VStack (alignment: .leading) {
                            Divider()
                            Text("Suggestions")
                                .font(.system(size: 21))
                                .padding(.top)
                                .padding(.bottom)
                                .bold()
                            Text("Here are some suggestions for you to deal with the weather.")
                                .font(.system(size: 16))
                                .padding(.top, -10)
                                .padding(.bottom,10)
                                .foregroundColor(.gray)
                            Text("Bring your umbrella")
                                .padding(.bottom, 1)
                            
                            Text("Avoid wearing white shoes")
                                .padding(.bottom, 1)
                            
                            Text("Bring sandals")
                                .padding(.bottom, 1)
                            
                            Text("Wear warm clothes")
                                .padding(.bottom, 1)
                            
                            Text("Avoid being outside for too long")
                                .padding(.bottom, 1)
                            
                            Text("Using closed transportation are highly recommended")
                                .padding(.bottom, 10)
                            
                            
                        }
                    }
                }
                    .padding(.horizontal, 17)
                    .padding(.vertical,12)
                    .background(Color(.white))
                    .cornerRadius(32)
                )
                
            case 3..<6:
                return AnyView( VStack{
                    HStack {
                        Spacer()
                        VStack {
                            Image(systemName: "cloud.heavyrain.fill")
                                .foregroundColor(.gray)
                                .font(.system(size: 48))
                                .padding()
                            Text("Heavy Rain")
                                .font(.system(size: 18))
                                .padding(.bottom)
                            
                        }
                        Spacer()
                        Divider()
                            .frame(height: 150)
                        Spacer()
                        VStack (alignment: .leading) {
                            Text("\(pikLocloc)")
                                .padding(.bottom, 1)
                                .font(.system(size: 18))
                                .bold()
                            Text("28°")
                                .padding(.top, 5)
                                .font(.system(size: 48))
                                .fontWeight(.thin)
                        }
                        Spacer()
                    }
                    HStack{
                        VStack (alignment: .leading) {
                            Divider()
                            Text("Suggestions")
                                .font(.system(size: 21))
                                .padding(.top)
                                .padding(.bottom)
                                .bold()
                            Text("Here are some suggestions for you to deal with the weather.")
                                .font(.system(size: 16))
                                .padding(.top, -10)
                                .padding(.bottom,10)
                                .foregroundColor(.gray)
                            Text("Bring your umbrella")
                                .padding(.bottom, 1)
                            
                            Text("Avoid wearing white shoes")
                                .padding(.bottom, 1)
                            
                            Text("Bring sandals")
                                .padding(.bottom, 1)
                            
                            Text("Wear warm clothes")
                                .padding(.bottom, 1)
                            
                            Text("Using closed transportation are highly recommended")
                                .padding(.bottom, 10)
                            
                            
                        }
                    }
                }
                    .padding(.horizontal, 17)
                    .padding(.vertical,12)
                    .background(Color(.white))
                    .cornerRadius(32)
                )
                
            case 6..<9:
                return AnyView( VStack{
                    HStack {
                        Spacer()
                        VStack {
                            Image(systemName: "cloud.drizzle.fill")
                                .foregroundColor(.gray)
                                .font(.system(size: 48))
                                .padding()
                            Text("Drizzle")
                                .font(.system(size: 18))
                                .padding(.bottom)
                            
                        }
                        Spacer()
                        Divider()
                            .frame(height: 150)
                        Spacer()
                        VStack (alignment: .leading) {
                            Text("\(pikLocloc)")
                                .padding(.bottom, 1)
                                .font(.system(size: 18))
                                .bold()
                            Text("28°")
                                .padding(.top, 5)
                                .font(.system(size: 48))
                                .fontWeight(.thin)
                        }
                        Spacer()
                    }
                    HStack{
                        VStack (alignment: .leading) {
                            Divider()
                            Text("Suggestions")
                                .font(.system(size: 21))
                                .padding(.top)
                                .padding(.bottom)
                                .bold()
                            Text("Here are some suggestions for you to deal with the weather.")
                                .font(.system(size: 16))
                                .padding(.top, -10)
                                .padding(.bottom,10)
                                .foregroundColor(.gray)
                            
                            Text("Bring your umbrella")
                                .padding(.bottom, 1)
                            
                            Text("Wear cap")
                                .padding(.bottom, 1)
                            
                            Text("Avoid wearing white shoes")
                                .padding(.bottom, 1)
                            
                            Text("Wear long sleeves clothes")
                                .padding(.bottom, 10)
                            
                            
                        }
                    }
                }
                    .padding(.horizontal, 17)
                    .padding(.vertical,12)
                    .background(Color(.white))
                    .cornerRadius(32)
                )
                
            case 9..<12:
                return AnyView(VStack{
                    HStack {
                        Spacer()
                        VStack {
                            Image(systemName: "cloud.sun.fill")
                                .foregroundColor(.gray)
                                .font(.system(size: 48))
                                .padding()
                            Text("Partly Cloudy")
                                .font(.system(size: 18))
                                .padding(.bottom)
                        }
                        Spacer()
                        Divider()
                            .frame(height: 150)
                        Spacer()
                        VStack (alignment: .leading) {
                            Text("\(pikLocloc)")
                                .padding(.bottom, 1)
                                .font(.system(size: 18))
                                .bold()
                            Text("33°")
                                .padding(.top, 5)
                                .font(.system(size: 48))
                                .fontWeight(.thin)
                        }
                        Spacer()
                    }
                    HStack{
                        VStack (alignment: .leading) {
                            Divider()
                            Text("Suggestions")
                                .font(.system(size: 21))
                                .padding(.top)
                                .padding(.bottom)
                                .bold()
                            Text("Here are some suggestions for you to deal with the weather.")
                                .font(.system(size: 16))
                                .padding(.top, -10)
                                .padding(.bottom,10)
                                .foregroundColor(.gray)
                            Text("Wear cap")
                                .padding(.bottom, 1)
                            
                            Text("Wear light colored clothes")
                                .padding(.bottom, 1)
                            
                            Text("You can wear sandals")
                                .padding(.bottom, 1)
                            
                            Text("Wear long sleeves clothes")
                                .padding(.bottom, 10)
                            
                            
                        }
                    }
                }
                    .padding(.horizontal, 17)
                    .padding(.vertical,12)
                    .background(Color(.white))
                    .cornerRadius(32)
                )
                
            case 12..<15:
                return AnyView(VStack{
                    HStack {
                        Spacer()
                        VStack {
                            Image(systemName: "sun.max.fill")
                                .foregroundColor(.gray)
                                .font(.system(size: 48))
                                .padding()
                            Text("Mostly Sunny")
                                .font(.system(size: 18))
                                .padding(.bottom)
                        }
                        Spacer()
                        Divider()
                            .frame(height: 150)
                        Spacer()
                        VStack (alignment: .leading) {
                            Text("\(pikLocloc)")
                                .padding(.bottom, 1)
                                .font(.system(size: 18))
                                .bold()
                            Text("37°")
                                .padding(.top, 5)
                                .font(.system(size: 48))
                                .fontWeight(.thin)
                        }
                        Spacer()
                    }
                    HStack{
                        VStack (alignment: .leading) {
                            Divider()
                            Text("Suggestions")
                                .font(.system(size: 21))
                                .padding(.top)
                                .padding(.bottom)
                                .bold()
                            Text("Here are some suggestions for you to deal with the weather.")
                                .font(.system(size: 16))
                                .padding(.top, -10)
                                .padding(.bottom,10)
                                .foregroundColor(.gray)
                            Text("Wear your sunscreen!")
                                .padding(.bottom, 1)
                            
                            Text("Avoid wearing dark colored & warm clothes")
                                .padding(.bottom, 1)
                            
                            Text("Bring extra water")
                                .padding(.bottom, 1)
                            
                            Text("Bring/wear cap")
                                .padding(.bottom, 10)
                            
                            
                        }
                    }
                }
                    .padding(.horizontal, 17)
                    .padding(.vertical,12)
                    .background(Color(.white))
                    .cornerRadius(32)
                )
                
            case 15..<18:
                return AnyView(VStack{
                    HStack {
                        Spacer()
                        VStack {
                            Image(systemName: "cloud.sun.fill")
                                .foregroundColor(.gray)
                                .font(.system(size: 48))
                                .padding()
                            Text("Partly Cloudy")
                                .font(.system(size: 18))
                                .padding(.bottom)
                        }
                        Spacer()
                        Divider()
                            .frame(height: 150)
                        Spacer()
                        VStack (alignment: .leading) {
                            Text("\(pikLocloc)")
                                .padding(.bottom, 1)
                                .font(.system(size: 18))
                                .bold()
                            Text("33°")
                                .padding(.top, 5)
                                .font(.system(size: 48))
                                .fontWeight(.thin)
                        }
                        Spacer()
                    }
                    HStack{
                        VStack (alignment: .leading) {
                            Divider()
                            Text("Suggestions")
                                .font(.system(size: 21))
                                .padding(.top)
                                .padding(.bottom)
                                .bold()
                            Text("Here are some suggestions for you to deal with the weather.")
                                .font(.system(size: 16))
                                .padding(.top, -10)
                                .padding(.bottom,10)
                                .foregroundColor(.gray)
                            
                            Text("Wear cap")
                                .padding(.bottom, 1)
                            
                            Text("Wear light colored clothes")
                                .padding(.bottom, 1)
                            
                            Text("You can wear sandals")
                                .padding(.bottom, 1)
                            
                            Text("Wear long sleeves clothes")
                                .padding(.bottom, 10)
                            
                            
                        }
                    }
                }
                    .padding(.horizontal, 17)
                    .padding(.vertical,12)
                    .background(Color(.white))
                    .cornerRadius(32)
                )
                
            case 18..<21:
                return AnyView(VStack{
                    HStack {
                        Spacer()
                        VStack {
                            Image(systemName: "cloud.fill")
                                .foregroundColor(.gray)
                                .font(.system(size: 48))
                                .padding()
                            Text("Mostly Cloudy")
                                .font(.system(size: 18))
                                .padding(.bottom)
                        }
                        Spacer()
                        Divider()
                            .frame(height: 150)
                        Spacer()
                        VStack (alignment: .leading) {
                            Text("\(pikLocloc)")
                                .padding(.bottom, 1)
                                .font(.system(size: 18))
                                .bold()
                            Text("29°")
                                .padding(.top, 5)
                                .font(.system(size: 48))
                                .fontWeight(.thin)
                        }
                        Spacer()
                    }
                    HStack{
                        VStack (alignment: .leading) {
                            Divider()
                            Text("Suggestions")
                                .font(.system(size: 21))
                                .padding(.top)
                                .padding(.bottom)
                                .bold()
                            Text("Here are some suggestions for you to deal with the weather.")
                                .font(.system(size: 16))
                                .padding(.top, -10)
                                .padding(.bottom,10)
                                .foregroundColor(.gray)
                            Text("You can wear any types of clothes")
                                .padding(.bottom, 1)
                            
                            Text("Wear pants/trousers to avoid mosquito bites")
                                .padding(.bottom, 1)
                            
                            Text("Long sleeves clothes are highly recommended")
                                .padding(.bottom, 10)
                            
                            
                        }
                    }
                }
                    .padding(.horizontal, 17)
                    .padding(.vertical,12)
                    .background(Color(.white))
                    .cornerRadius(32)
                )
                
            case 21..<24:
                return AnyView(VStack{
                    HStack {
                        Spacer()
                        VStack {
                            Image(systemName: "cloud.fill")
                                .foregroundColor(.gray)
                                .font(.system(size: 48))
                                .padding()
                            Text("Mostly Cloudy")
                                .font(.system(size: 18))
                                .padding(.bottom)
                        }
                        Spacer()
                        Divider()
                            .frame(height: 150)
                        Spacer()
                        VStack (alignment: .leading) {
                            Text("\(pikLocloc)")
                                .padding(.bottom, 1)
                                .font(.system(size: 18))
                                .bold()
                            Text("27°")
                                .padding(.top, 5)
                                .font(.system(size: 48))
                                .fontWeight(.thin)
                        }
                        Spacer()
                    }
                    HStack{
                        VStack (alignment: .leading) {
                            Divider()
                            Text("Suggestions")
                                .font(.system(size: 21))
                                .padding(.top)
                                .padding(.bottom)
                                .bold()
                            Text("Here are some suggestions for you to deal with the weather.")
                                .font(.system(size: 16))
                                .padding(.top, -10)
                                .padding(.bottom,10)
                                .foregroundColor(.gray)
                            
                            Text("Warm clothes are recommended")
                                .padding(.bottom, 1)
                            
                            Text("Wear pants/trousers to avoid mosquito bites")
                                .padding(.bottom, 10)
                            
                            
                        }
                    }
                }
                    .padding(.horizontal, 17)
                    .padding(.vertical,12)
                    .background(Color(.white))
                    .cornerRadius(32)
                )
                
            default:
                print("pogihajima")
                return AnyView(VStack{Text("")})
                
            }
        }   else {
            print("nonono")
            return AnyView(VStack{Text("")})
        }
    }
}
struct WeatherSheetView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherSheetView(pikLoc: .constant("IKEA"), pikLocloc: .constant("Tangerang"))
    }
}
