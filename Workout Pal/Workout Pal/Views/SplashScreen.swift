import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Color.purple // background color or image
            
            VStack {
                Spacer()
                
                Image("zyzz.jpeg")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 4)
                    )
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
                    .padding()
                
                Text("We Go Gym!")
                    
                    .font(Font.custom("Courier-Bold", size: 40)) 
                    .foregroundColor(.white)
                    .padding()
                    .padding()
                
                Spacer()
            }
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
