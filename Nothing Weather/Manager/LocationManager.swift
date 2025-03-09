import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?
    
    @Published var isLocationGranted: Bool = false
    @Published var isLoading: Bool = false
    
    override init() {
        super.init()
        manager.delegate = self
        checkLocationAuthorization() // Start the authorization check as soon as the object is initialized
    }
    
    // Function to check the location authorization status
    func checkLocationAuthorization() {
        // Check the current authorization status
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request authorization if not determined
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            // Handle the case when permission is denied or restricted
            isLocationGranted = false
        case .authorizedWhenInUse, .authorizedAlways:
            // Location access is granted
            isLocationGranted = true
            requestLocation() // Proceed with requesting location data
        @unknown default:
            break
        }
    }

    // Delegate method that gets called when the authorization status changes
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization() // Recheck the authorization when it changes
    }

    // Function to request the location
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }

    // Delegate method that gets called when new location data is available
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.first else { return }
        // Ensure location updates are done on the main thread
        DispatchQueue.main.async {
            self.location = newLocation.coordinate
            self.isLocationGranted = true
            self.isLoading = false
        }
    }

    // Delegate method that gets called if location update fails
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error Getting Location: \(error)")
        // Ensure failure handling is done on the main thread
        DispatchQueue.main.async {
            self.isLoading = false
            self.isLocationGranted = false
        }
    }
}
