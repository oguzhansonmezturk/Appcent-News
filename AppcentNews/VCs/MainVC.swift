//
//  MainVC.swift
//  AppcentNews
//
//  Created by oguzhan on 14.05.2024.
//

import SwiftUI

struct MainVC: View {
    
    @State private var tabSelection: Int = 0
    
    var body: some View {
        TabView(selection: $tabSelection,
                content:  {
            NewsVC()
                .tabItem {
                    VStack {
                        Image(systemName: tabSelection == 0 ? "newspaper.fill" : "newspaper")
                        Text("News")
                    }
                }
                .tag(1)
            
            FavoriteNews()
                .tabItem {
                    VStack {
                        Image(systemName: tabSelection == 1 ? "heart.fill" : "heart")
                        Text("Favorites")
                    }
                }
                .tag(2)
        })
        .animation(.default, value: tabSelection)
    }
}

struct MainVC_Previews: PreviewProvider {
    static var previews: some View {
        MainVC()
    }
}
