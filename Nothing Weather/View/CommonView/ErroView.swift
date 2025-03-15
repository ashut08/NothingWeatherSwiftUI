

import SwiftUI
struct ErroView: View {
    var body: some View {
        VStack(spacing:30)  {
            Spacer()
         
            CustomImageView(imageName: "error",width: 120,height: 120)
          
            
            Text("LOCATION PERMISSION")
                .fontWeight(.regular).font(.system(size: 12)).customFont(.medium,14)
            Spacer()
         
            HStack  {
                Spacer(minLength: 10)
                ZStack {
                            
                            Circle()
                        .fill(.red)
                                .frame(width: 50, height: 50)
                            
                          
                    Image("locationNotGranted").frame(width: 50,height: 50)
                        }
                
                Spacer()
                
                VStack(alignment: .leading,spacing: 5)  {
                    Text("LOCATION PERMISSION").customFont(.semiBold, 14)
                    Text("Enable the location permission to get weather information in your current location.").customFont(.regular, 12)            .foregroundColor(.white.opacity(0.8))
                    
                    Text("Edit permission").underline().customFont(.semiBold, 14)
            
                     
                        .onTapGesture {
                            openAppSettings()
                            
                        }
                    
                    
                    
                    
                    
                }}.padding(20).background(.white.opacity(0.1)).cornerRadius(100).shadow(color: .black, radius: 8, x: 0, y: 4)
                .padding([.leading, .trailing],15)
            
            
        }   .preferredColorScheme(.dark)
    }
    func openAppSettings() {
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(appSettings) {
                    UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                }
            }
        }
}

#Preview {
    ErroView()
}
