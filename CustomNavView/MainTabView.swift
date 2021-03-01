//
//  MainTabView.swift
//  CustomNavView
//
//  Created by 王小劣 on 2021/2/28.
//

import SwiftUI

struct MainTabView: View {
    @State var selectedTab: Tabs = .tab1
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                HomeTabView()
                        .tabItem {
                            Image(systemName: "house.fill")
                                .offset(y: 5)
                            Text("首页")
                        }
                        .tag(Tabs.tab1)

                HomeTabView()
                            .tabItem {
                                Image(systemName: "cart.fill")
                                    .offset(y: 5)
                                Text("购物车")
                            }
                            .tag(Tabs.tab2)

                HomeTabView()
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("我")
                        }
                        .tag(Tabs.tab3)
            }
            .navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle(returnNaviBarTitle(tabSelection: selectedTab))
        }
        .accentColor(Color.orange)
        // .environment(\.colorScheme, 1 == 1 ? .dark : .light)
    }
}

enum Tabs {
       case tab1, tab2, tab3
}

func returnNaviBarTitle(tabSelection: Tabs) -> String {
    // this function will return the correct NavigationBarTitle when different tab is selected.
        switch tabSelection {
        case .tab1: return "首页"
        case .tab2: return "购物车"
        case .tab3: return "我的"
        }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            //.environmentObject(FetchRingData())
    }
}
