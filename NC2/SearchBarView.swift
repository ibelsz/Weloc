//
//  SearchBarView.swift
//  NC2
//
//  Created by Belinda Angelica on 19/05/23.
//

import SwiftUI
import MapKit

struct SearchBarView: View {
    @State var offset : CGFloat = 0
    @Binding var isEditing: Bool
    @State var pikLoc: String = ""
    @State var pikLocloc: String = ""
    @StateObject var locationManager: MapViewModel = .init()
//    //Nav tag to push view to MapView
    @State var navigationTag: String?
    
    var body: some View {
        
        HStack {
            Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    
            
            TextField("Search Location", text: $locationManager.searchText)
                .onTapGesture {
                    self.isEditing = true
                    offset = 0
                }
        
            if !locationManager.searchText.isEmpty {
                Spacer()
                
                Button(action: {
                    self.isEditing = false
                    self.locationManager.searchText = ""
                    
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 25))
                        .foregroundColor(.gray)
                        .padding(.top)

                }
                .padding(.trailing, 10)
                .animation(.easeInOut, value: !isEditing)
            }
        }
        .padding(7)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding(.horizontal, 10)
        
        if let places = locationManager.fetchedPlaces,!places.isEmpty{
            List{
                ForEach(places,id: \.self){place in
                    Button{
                        if let coordinate = place.location?.coordinate {
                            locationManager.pickedLocation = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
                            locationManager.mapView.region = .init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                            locationManager.fetchCoordinate = coordinate
                                pikLoc = "\(place.name ?? "")"
                                pikLocloc = "\(place.locality ?? "")"
                        }
                        navigationTag = "MAPVIEW"
                    } label: {
                        HStack(spacing: 15){
                            Image(systemName: "mappin.circle.fill")
                                .font(.title2)
                                .foregroundColor(.gray)
                            VStack (alignment: .leading, spacing: 6) {
                                Text(place.name ?? "")
                                    .font(.title3.bold())

                                Text(place.locality ?? "")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .background{
                NavigationLink(tag: "MAPVIEW", selection: $navigationTag){
                    MapViewSelection(pikLoc: $pikLoc, pikLocloc: $pikLocloc)
                        .environmentObject(locationManager)
                        .navigationBarBackButtonHidden(true)
                } label: {}
                    .labelsHidden()
            }
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(isEditing: .constant(false), pikLoc: "Ikea", pikLocloc: "The Breeze")
    }
}

////MapView Live Selection
struct MapViewSelection: View{
    @EnvironmentObject var locationManager: MapViewModel
    @State var offset : CGFloat = 0
    @Binding var pikLoc: String
    @Binding var pikLocloc: String



    var body: some View{
        ZStack{
            MapViewHelper().environmentObject(locationManager).ignoresSafeArea()
            
            GeometryReader{reader in
                VStack{
                    WeatherSheetView(pikLoc: $pikLoc, pikLocloc: $pikLocloc)
                        .offset(y: reader.frame(in: .global).height - 280)
                    //adding gesture
                        .offset(y: offset)
                        .gesture(DragGesture().onChanged({(value) in
                            
                            withAnimation{
                                //cek arah scroll
                                //scroll ke atas
                                //pake startLocation karena nilainya berubah2 pas kita scroll atas & bawah
                                if value.startLocation.y > reader.frame(in: .global).midX{
                                    
                                    if value.translation.height < 0 && offset >
                                        (-reader.frame(in: .global).height + 280){
                                        
                                        offset = value.translation.height
                                    }
                                }
                                
                                if value.startLocation.y < reader.frame(in: .global).midX{
                                    
                                    if value.translation.height > 0 && offset < 0 {
                                        
                                        offset = (-reader.frame(in: .global).height + 280) + value.translation.height
                                        
                                    }
                                }
                            }
                            
                        }).onEnded({(value) in
                            
                            withAnimation{
                                //cek pull up screen
                                if value.startLocation.y > reader.frame(in: .global).midX{
                                    
                                    if -value.translation.height > reader.frame(in: .global).midX{
                                        
                                        offset = (-reader.frame(in: .global).height + 280)
                                        
                                        return
                                    }
                                    offset = 0
                                }
                                
                                if value.startLocation.y < reader.frame(in: .global).midX{
                                    
                                    if value.translation.height < reader.frame(in: .global).midX{
                                        
                                        offset = (-reader.frame(in: .global).height + 280)
                                        
                                        return
                                    }
                                    offset = 0
                                }
                            }
                        }))
                    
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)

        }
    }
}

struct MapViewHelper: UIViewRepresentable {
    @EnvironmentObject var locationManager: MapViewModel
    func makeUIView(context: Context) -> MKMapView {
        return locationManager.mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
