//
// Created by Karel Dohnal on 10.04.2022.
//

import SwiftUI
import Foundation

struct Home: View {
    @Binding var authenticated: Bool
    var body: some View {
        VStack() {
            Text("Ahoj holky!\n blízko. už je skoro hotový! 🥳").multilineTextAlignment(.center)
            Button(action: logOut) {
                Text("Odhlásit se")
            }
        }
    }

    private func logOut() {
        withAnimation {
            authenticated = false
        }
    }
}