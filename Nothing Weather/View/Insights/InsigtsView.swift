//
//  InsigtsView.swift
//  Nothing Weather
//
//  Created by mac on 30/04/25.
//
import SwiftUI
struct InsigtsView :View {
    
    var viewModel: WeatherViewModel
    
    var body: some View {
        
        HStack{
            VStack{
                
                Text("\(Int(viewModel.weather?.first?.temperature? .metric?.value?.rounded() ?? 0))°").customFont(.regular, 60)            .foregroundColor(.black)

            }
            .frame(width: 200, height: 200)
                       .padding(.vertical, 21)
                       .padding(.horizontal, 18)
                       .background(.white)
                       .clipShape(Circle())
          
            
            VStack{
                VStack(alignment: .leading){
                    
                    Text("Air Quality \(viewModel.forecastData?.dailyForecasts?.first?.airAndPollen?.first?.categoryValue ?? 0)").customFont(.semiBold, 14)  .foregroundColor(.white)
                    Text( viewModel.forecastData?.dailyForecasts?.first?.airAndPollen?.first?.category ?? "0").customFont(.regular, 14)  .foregroundColor(.white)


                }
                           .frame(maxWidth: .infinity)
                           .padding(.vertical, 21)
                           .padding(.horizontal, 18)
                           .background(AppColors.tertiary)
                           .cornerRadius(100)
                
                VStack(alignment: .leading){
                    
                    Text("UV Index 0\(viewModel.weather?.first?.uvIndex ?? 0)").customFont(.regular, 14) .foregroundColor(.white)
                    Text(viewModel.weather?.first?.uvIndexText ?? "0").customFont(.semiBold, 14)  .foregroundColor(.white)


                }
                           .frame(maxWidth: .infinity)
                           .padding(.vertical, 21)
                           .padding(.horizontal, 18)
                           .background(AppColors.tertiary)
                           .cornerRadius(100)
                
              
            }
        }
        
    }
    
    
    
}
