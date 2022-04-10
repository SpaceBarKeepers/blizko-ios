//
//  blizkoApp.swift
//  blizko
//
//  Created by Karel Dohnal on 10.04.2022.
//

import SwiftUI

@main
struct blizkoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
