//
//  MainView.swift
//  HW1_FindMy
//
//  Created by zjucvglab509 on 2025/3/12.
//

import SwiftUI
import MapKit

struct MainView: View {
        
    @State private var sheetHeight: CGFloat = 50 // 初始留出的拖拽区域
    let minHeight: CGFloat = 50 // 只显示拖拽区域时的高度
    let midHeight: CGFloat = 300 // 半屏
    let maxHeight: CGFloat = UIScreen.main.bounds.height * 0.8 // 全屏
    
    var body: some View {
        TabView{
            //Text("尚未实现")
                //.tabItem {
                    //Image(systemName: "person.and.person")
                    //Text("People")
                //}
            VStack{
                VStack{
                    MapView()
                        .edgesIgnoringSafeArea(.top)
                }
                .overlay(
                    BottomSheetView(sheetHeight: $sheetHeight, minHeight: minHeight, midHeight: midHeight, maxHeight: maxHeight)
                )
            }
            .tabItem
            {
                Image(systemName: "ipad")
                Text("Devices")
            }
            Text("尚未实现")
                .tabItem {
                    Image(systemName: "circle.grid.2x2")
                    Text("Items")
                }
            Text("尚未实现")
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Me")
                }
        }
    }
}

struct BottomSheetView: View {
    @Binding var sheetHeight: CGFloat
    let minHeight: CGFloat
    let midHeight: CGFloat
    let maxHeight: CGFloat

    var body: some View {
        VStack {
            Capsule()
                .frame(width: 40, height: 6)
                .foregroundColor(.gray.opacity(0.5))
                .padding(.top, 8)

            DevicesSheetView()
                .frame(height: sheetHeight - 20) // 减去拖拽区域的高度
                .background(Color.white)
                .cornerRadius(20)
        }
        .frame(maxWidth: .infinity)
        .background(Color.white.shadow(radius: 5))
        .offset(y: UIScreen.main.bounds.height - sheetHeight)
        .gesture(
            DragGesture()
                .onChanged { value in
                    let newHeight = sheetHeight - value.translation.height
                    if newHeight > minHeight && newHeight < maxHeight {
                        sheetHeight = newHeight
                    }
                }
                .onEnded { value in
                    let newHeight = sheetHeight - value.predictedEndTranslation.height
                    withAnimation(.spring()) {
                        if newHeight > midHeight {
                            sheetHeight = maxHeight // 全屏
                        } else if newHeight > minHeight + 50 {
                            sheetHeight = midHeight // 半屏
                        } else {
                            sheetHeight = minHeight // 仅显示拖拽区域
                        }
                    }
                }
        )
    }
}

struct DeviceItems:View {
    let device: String
    let deviceName: String
    let location: String
    let duration: String
    let distance: String
    
    @State var locationReplay: String
    @State var durationReplay: String
    @State var distanceReplay: String
    
    init(device: String, deviceName: String, location: String, duration: String, distance: String) {
        self.device = device
        self.deviceName = deviceName
        self.location = location
        self.duration = duration
        self.distance = distance
        
        _locationReplay = State(initialValue: location.isEmpty ? "This " + device : location)
        _durationReplay = State(initialValue: duration.isEmpty ? "" : "• " + duration)
        _distanceReplay = State(initialValue: distance.isEmpty ? "With You" : distance)
        }
    
    var body: some View {
        HStack{
            Image(systemName: device)
                .padding(.trailing)
            VStack{
                Text(deviceName)
                HStack{
                    Text(locationReplay)
                    Text(durationReplay)
                }
            }
            Text(distanceReplay)
        }
    }
}

struct MapView:View {
    
    // 设定初始显示区域为Beijing
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 39.9, longitude: 116.4),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    
    var body: some View {
        Map(position: .constant(.region(region))) {
            // 使用 Annotation 实现自定义标注
            Annotation("北京", coordinate: CLLocationCoordinate2D(latitude: 39.9, longitude: 116.4)) {
                VStack {
                    Image(systemName: "iphone.gen3.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.blue)
                    Circle()
                        .fill(Color.red)
                        .frame(width: 10, height: 10)
                }
            }
        }
    }
}

struct DevicesSheetView:View {
    var body: some View {
        VStack {
            VStack{
                HStack{
                    Text("Devices")
                        .padding()
                    Spacer()
                }
                .frame(height: 50)
            }
            List{
                DeviceItems(device: "iphone", deviceName: "Your iPhone", location: "This iPhone", duration: "", distance: "")
                DeviceItems(device: "airpods", deviceName: "Your AirPods Pro", location: "someWhere", duration: "Now", distance: "0.1公里")
            }
        }
    }
}


#Preview {
    MainView()
}
