//
//  HomeView.swift
//  Nothing Weather
//
//  Created by mac on 08/03/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var locationManager = LocationManager()
    var body: some View {
        NavigationStack {
            if(locationManager.isLocationGranted){
                MainView(weatherRepository: WeatherRepositoryImpl())
            }else{
                ErroView()
            }
        }
            .navigationBarTitleDisplayMode(.inline)

        .toolbar {
            ToolbarItem(placement: .principal) {
                Text( !locationManager.isLocationGranted ? "Error".uppercased(with: .autoupdatingCurrent) : "Location".lowercased(with: .autoupdatingCurrent)).customFont(.bold,18).customFont(.bold,14)
              
                       }
                       
            // Leading item
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {}, label: {
                    Image(systemName: "line.horizontal.3")
                                           .imageScale(.large)
                                           .foregroundColor(.white)
                })
            }
            
            
            // Trailing item
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}, label: {
                    CustomImageView(imageName: "settings",width: 30,height: 30)
                    
                })
            }
        } .onAppear(){
            locationManager.requestLocation()
        }
    }
    
  
    
    
    
}

#Preview {
    HomeView()
}
