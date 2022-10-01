//
//  SimpleSpeakerApp.swift
//  SimpleSpeaker
//
//  Created by John Weddell on 30/9/2022.
//

import SwiftUI

@main
struct SimpleSpeakerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.persistentContainer.viewContext)
        }
    }
}
