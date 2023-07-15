//
//  CoreLoactionUI.swift
//  SwiftUIPractice
//
//  Created by tunko on 2022/09/27.
//

import SwiftUI
import CoreLocationUI
import CoreLocation
import MapKit

struct CoreLoactionUI: View {
    
    @StateObject var locationManager = LocationManager()
 
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true, annotationItems: locationManager.coffeeShops, annotationContent: { shop in
                MapMarker(coordinate: shop.mapItem.placemark.coordinate, tint: .purple)
            })
            .ignoresSafeArea()
            
            LocationButton(.currentLocation) {
                print("Location Requested...")
                locationManager.manager.requestLocation()
            }
            .frame(width: 210, height: 50)
            .symbolVariant(.fill)
            .foregroundColor(.white)
            .tint(.purple)
            .clipShape(Capsule())
            .padding()
        }
        .overlay(
            Text("Coffee Shop's")
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.ultraThinMaterial)
            ,alignment: .top
        )
    }
}

struct CoreLoactionUI_Previews: PreviewProvider {
    static var previews: some View {
        CoreLoactionUI()
    }
}

// Location Manager...
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var manager = CLLocationManager()
    
    // Region...
    @Published var region: MKCoordinateRegion = .init()
    @Published var coffeeShops: [Shop] = []
    
    // Setting Delegate
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last?.coordinate else {
            return
        }
        
        region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        print(location)
        
        Task {
            await fetchCoffeeShops()
        }
    }
    
    // Sample Location Search Aync Task...
    
    func fetchCoffeeShops() async {
        do {
            let request = MKLocalSearch.Request()
            request.region = region
            request.naturalLanguageQuery = "CU" // "만세육간"//"커피"//"Coffee Shops"
            
            let query = MKLocalSearch(request: request)
            let response = try await query.start()
            
            await MainActor.run {
                self.coffeeShops = response.mapItems.compactMap { item in
                    return Shop(mapItem: item)
                }
            }
            
        } catch {
            
        }
    }
    
}

struct Shop: Identifiable {
    var id = UUID().uuidString
    var mapItem: MKMapItem
}
