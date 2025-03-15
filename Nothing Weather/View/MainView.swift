import SwiftUI

struct MainView: View {
    @StateObject private var viewModel: WeatherViewModel
    @StateObject var locationManager = LocationManager()
    
    @State private var hasFetchedLocation = false // Flag to track if the API has been called
    
    init(weatherRepository: WeatherRepository) {
        _viewModel = StateObject(wrappedValue: WeatherViewModel(weatherRepository: weatherRepository))
    }
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView()
        }
        else if viewModel.errorMessage != nil {
            Text(viewModel.errorMessage ?? "Error")
        }
        else {
            VStack {
                Text(viewModel.weather?[0].mobileLink ?? "Loading...").customFont(.regular, 20)
                
                Text("Hello, SwiftUI!").customFont(.regular, 12)
                Text("Hello, SwiftUI!").customFont(.bold, 20)
                CustomImageView(imageName: "error", width: 100, height: 100)
            }
            .onAppear {
                // Ensure the fetch only happens once
                if !hasFetchedLocation {
                    Task {
                        await viewModel.fetchLocationKey(lat: locationManager.location?.latitude ?? 30.70, long: locationManager.location?.longitude ?? 76.71)
                        hasFetchedLocation = true // Set the flag to true after the API call
                    }
                }
            }
        }
    }
}
