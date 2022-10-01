//
//  ContentView.swift
//  SimpleSpeaker
//
//  Created by John Weddell on 30/9/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.white, Color.speaker]),
                               startPoint: .top,
                               endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    NavigationLink(destination: SpeakerListView(color: Color.speaker)) {
                        Text("Speaker List")
                    }
                }
            }
        }
    }
}

