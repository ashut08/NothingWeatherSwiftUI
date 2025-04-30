import SwiftUI

struct MainView: View {
    @StateObject private var viewModel: WeatherViewModel
    @StateObject var locationManager = LocationManager()
    @State private var showNavigationBar = true
        @State private var scrollOffset: CGFloat = 0
    
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
            NavigationView {
                
                
                ScrollView{
                    
                    VStack {
                        Spacer(minLength: 100)
                        
                        CustomImageView(imageName: getSystemImagePath(text: viewModel.weather?[0].weatherText?.lowercased() ?? "cloud", isDayTime: (viewModel.weather?[0].isDayTime ?? false)), width: 130, height: 130)
                        
                        Text(viewModel.weather?[0].weatherText ?? "NA")
                        
                        InsigtsView(viewModel: viewModel)
                    }
                }            }
            .onAppear {
                // Ensure the fetch only happens once
                if !hasFetchedLocation {
                    Task {
                        await viewModel.fetchLocationKey(lat:   30.70, long:  76.71)
                        hasFetchedLocation = true // Set the flag to true after the API call
                    }
                }
            }
        }
    }
}
#Preview {
    MainView(weatherRepository: WeatherRepositoryImpl() )
}
