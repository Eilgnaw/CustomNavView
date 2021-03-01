//
//  ContentView.swift
//  CustomNavView
//
//  Created by 王小劣 on 2021/2/28.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        ADimgView()
    }
}


struct ADimgView: View {
    @State var currentIndex: Int = 0 {
        didSet {
            if currentIndex == 3 {
                self.items = [3, 0, 1, 2]
                self.tabid += 1
            }
            if currentIndex == 0 {
                self.items = [0, 1, 2, 3]
                self.tabid -= 1
            }
        }
    }
    
    @State var items = [0, 1, 2, 3]
    @State var tabid = 0
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    var body: some View {
        TabView(selection: $currentIndex){
            ForEach(items, id: \.self ) {index in
                ZStack {
                    CardView(imgindex: index)
                    Text(" \(index) ")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                        .background(Color.black)
                }
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .id(tabid)
        .cornerRadius(10)
        .padding()
        .onChange(of: currentIndex) { newValue in
            print("Name changed to \(currentIndex)!")
        }
//        .onReceive(timer) { _ in
//            let current = (self.currentIndex + 1) % self.items.count
//            withAnimation(.easeIn(duration: 2)) {
//                self.currentIndex = current
//            }
//        }
    }
}


class TabsViewModel: ObservableObject {
    @Published var items = [0, 1, 2, 3]
    @Published var selectedItem = 0 {
        didSet {
            if let index = items.firstIndex(of: selectedItem), index >= items.count - 2 {
                items = items + [items.last! + 1]
                items.removeFirst()
            }
            
            if let index = items.firstIndex(of: selectedItem), index <= 1 {
                items = [items.first! - 1] + items
                items.removeLast()
            }
        }
    }
}

struct TabsView: View {
    @StateObject var vm = TabsViewModel()
    
    var body: some View {
        TabView(selection: $vm.selectedItem) {
            ForEach(vm.items, id: \.self) { item in
                Text(item.description)
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 0,
                           maxHeight: .infinity,
                           alignment: .topLeading
                    )
                    .background(Color(hue: .random(in: 0...0.99), saturation: .random(in: 0...0.99), brightness: 0.5))
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
  func navigationBarColor(backgroundColor: UIColor, tintColor: UIColor) -> some View {
    self.modifier(NavigationBarColor(backgroundColor: backgroundColor, tintColor: tintColor))
  }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

struct NavigationBarColor: ViewModifier {

  init(backgroundColor: UIColor, tintColor: UIColor) {
    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.configureWithOpaqueBackground()
    coloredAppearance.backgroundColor = backgroundColor
    coloredAppearance.titleTextAttributes = [.foregroundColor: tintColor]
    coloredAppearance.largeTitleTextAttributes = [.foregroundColor: tintColor]

    UINavigationBar.appearance().standardAppearance = coloredAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    UINavigationBar.appearance().compactAppearance = coloredAppearance
    UINavigationBar.appearance().tintColor = tintColor
  }

  func body(content: Content) -> some View {
    content
  }
}
