//
//  MapView.swift
//  NC2
//
//  Created by Belinda Angelica on 19/05/23.
//

import SwiftUI
import CoreLocation
import MapKit
import Combine //combine framework

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    @StateObject var locationManager: MapViewModel = .init()
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -6.302289, longitude: 106.652296), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    @State var offset : CGFloat = 0
    private let geocoder = CLGeocoder()
    

    
    var body: some View {
        ZStack (alignment: Alignment(horizontal: .center, vertical: .bottom), content:
                    {
            Map(coordinateRegion: $region, showsUserLocation: true)
                .ignoresSafeArea(.all, edges: .all)
                .onAppear{
                    locationManager.locationManager?.startUpdatingLocation()
                    }
            
            GeometryReader{reader in
                VStack{
                    SheetView(pikLoc: .constant("\(locationManager.currentLocationName)"), pikLocloc: .constant("\(locationManager.currentLocationLocality)"))
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
        })
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}



final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate, MKMapViewDelegate{
    @Published var mapView: MKMapView = .init()
    var locationManager: CLLocationManager?
    
    @Published var searchText: String = ""
    var cancellable: AnyCancellable?
    @Published var fetchedPlaces: [CLPlacemark]?
    
    @Published var pickedLocation: CLLocation?
    
    @Published var fetchCoordinate: CLLocationCoordinate2D?
    @Published var currentLocationName = ""
    @Published var currentLocationLocality = ""

    
    override init() {
        super.init()
        cancellable = $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveValue: { value in
                if value != ""{
                    self.fetchPlaces(value: value)
                } else {
                    self.fetchedPlaces = nil
                }
            })
    }
    
    func fetchPlaces(value: String){
        //        print(value) --> fetching loc using MKLocalSearch
        Task {
            do{
                let request = MKLocalSearch.Request()
                request.naturalLanguageQuery = value.lowercased()
                
                let response = try await MKLocalSearch(request: request).start()
                await MainActor.run(body: {
                    self.fetchedPlaces = response.mapItems.compactMap({ item -> CLPlacemark? in
                        return item.placemark
                        
                    })
                })
            }
            catch{
                //handle error
                
            }
        }
    }
    
    func checkIfLocationServicesIsEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else{
            print("Turn On Location to Use The App")
        }
    }
    func checkLocationAuthorization(){
        guard let locationManager = locationManager else{ return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely to asdasdasd")
        case .denied:
            print("asdasdasdasd")
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }

    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        guard let newLocation = view.annotation?.coordinate else {return}
        self.pickedLocation = .init(latitude: newLocation.latitude, longitude: newLocation.longitude)
   
        // Perform reverse geocoding for the picked location
        reverseGeocodeCurrentLocation()
    }
    
    
    func reverseGeocodeCurrentLocation() {
            guard let location = locationManager?.location else { return }
            
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Reverse geocoding failed: \(error.localizedDescription)")
                    return
                }
                
                guard let placemark = placemarks?.first else {
                    print("No placemark found.")
                    return
                }
                
                if let name = placemark.name {
                    DispatchQueue.main.async {
                        self.currentLocationName = name
                    }
                }
                
                if let locality = placemark.locality {
                    DispatchQueue.main.async {
                        self.currentLocationName = locality
                        
                    }
                    
                }
            }
        }
}




