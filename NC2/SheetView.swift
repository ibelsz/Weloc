//
//  SheetView.swift
//  NC2
//
//  Created by Belinda Angelica on 20/05/23.
//

import SwiftUI
import CoreLocation

struct SheetView: View {
    @State var offset : CGFloat = 0
    @State private var isEditing = false
    @Binding var pikLoc: String
    @Binding var pikLocloc: String
    
    
    var body: some View {
        ZStack {
            NavigationView{
                VStack {
                    Capsule()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 50, height: 5)
                        .padding(.top)
                        .padding(.bottom,5)
                    
                    SearchBarView(isEditing: $isEditing)
                    
                    
                    if !isEditing {
                        
                        VStack (alignment: .leading) {
                            
                            Text("Recently Viewed")
                                .bold()
                                .padding(.top)
                                .font(.system(size: 18))
                            if pikLoc != "" {
                                ZStack (alignment: .leading){
                                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                        .fill(.white)
                                        .shadow(radius: 0.5)
                                        .frame(maxWidth: .infinity, maxHeight: 120)
                                    
                                    HStack {
                                        Image(systemName: "mappin.circle.fill")
                                            .padding(30)
                                            .font(.system(size: 50))
                                            .foregroundColor(.gray)
                                        VStack (alignment: .leading) {
                                            Text("\(pikLoc)")
                                                .padding(.bottom, 1)
                                                .font(.system(size: 18))
                                                .bold()
                                            Text("\(pikLocloc)")
                                                .padding(.bottom, 1)
                                                .font(.system(size: 18))
                                        }
                                    }
                                }
                            } else {
                                ZStack (alignment: .leading){
                                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                        .fill(.white)
                                        .shadow(radius: 0.5)
                                        .frame(maxWidth: .infinity, maxHeight: 120)
                                    HStack {
                                        Image(systemName: "mappin.circle.fill")
                                            .padding(30)
                                            .font(.system(size: 50))
                                            .foregroundColor(.gray)
                                        VStack (alignment: .leading) {
                                            Text("Current Location")
                                                .padding(.bottom, 2)
                                                .font(.system(size: 18))
                                                .bold()
                                            Text("BSD Green Office Park")
                                                .padding(.bottom, 1)
                                                .font(.system(size: 16))
                                                .bold()
                                            Text("Tangerang")
                                                .padding(.bottom, 1)
                                                .font(.system(size: 16))
                                        }
                                    }
                                }
                            }
                            
                            Text("Current Weather")
                                .bold()
                                .padding(.top)
                                .font(.system(size: 18))
                            
                            Text("Below is the weather predictions by the time your arrive at your destination.")
                                .foregroundColor(.gray)
                                .font(.system(size: 16))
                                .padding(.bottom,1)
                            Text("This area is having ") +
                            Text("warm temperature & nice amount of sunlight ").bold() +
                            Text("now. Temperature might rise as you reach mid day.")
                            
                            ScrollView {
                                VStack{
                                    HStack {
                                        Spacer()
                                        VStack {
                                            Image(systemName: "cloud.sun.fill")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 48))
                                                .padding()
                                            Text("Partly Cloudy")
                                                .font(.system(size: 18))
                                                .padding(.bottom)
                                            
                                        }
                                        Spacer()
                                        Divider()
                                            .frame(height: 150)
                                        Spacer()
                                        VStack (alignment: .leading) {
                                            Text("\(pikLocloc)")
                                                .padding(.bottom, 1)
                                                .font(.system(size: 18))
                                                .bold()
                                            Text("30°")
                                                .padding(.top, 5)
                                                .font(.system(size: 48))
                                                .fontWeight(.thin)
                                        }
                                        Spacer()
                                    }
                                    HStack{
                                        VStack (alignment: .leading) {
                                            Divider()
                                            Text("Suggestions")
                                                .font(.system(size: 21))
                                                .padding(.top)
                                                .padding(.bottom)
                                                .bold()
                                            Text("Here are some suggestions for you to deal with the weather.")
                                                .font(.system(size: 16))
                                                .padding(.top, -10)
                                                .padding(.bottom,10)
                                                .foregroundColor(.gray)
                                            Text("Wear light colored clothes")
                                                .padding(.bottom, 1)
                                            
                                            Text("Any types of shoes are recommended")
                                                .padding(.bottom, 1)
                                            
                                            Text("Bring extra water")
                                                .padding(.bottom, 1)
                                            
                                            Text("Bring cap")
                                                .padding(.bottom, 10)
                                        }
                                    }
                                }
                                .padding(.horizontal, 17)
                                .padding(.vertical,12)
                                .background(Color(.white))
                                .cornerRadius(32)
                            }
                        }
                    }
                    
                    
                    else {
                        Text("")
                    }
                    
                    Spacer()
                }
                .padding(.vertical,10)
                .padding(.horizontal)
                .background(BlurView(style: .systemMaterial))
                .cornerRadius(15)
                .edgesIgnoringSafeArea(.bottom)
                
            }
            
            .navigationBarBackButtonHidden(true)
        }
        //        .onTapGesture (count: 1){
        //            self.isEditing = true
        //            offset = 0
        //        }
    }
    
    
    
    struct SheetView_Previews: PreviewProvider {
        static var previews: some View {
            SheetView(pikLoc: .constant("BSD Green Office Park"), pikLocloc: .constant("Tangerang"))
        }
    }
}
