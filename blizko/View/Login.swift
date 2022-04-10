//
// Created by Karel Dohnal on 10.04.2022.
//

import SwiftUI
import Foundation

struct Login: View {
    @Binding var authenticated: Bool
    var body: some View {
        VStack() {
            Text("Zkus se přihlásit!").multilineTextAlignment(.center)
            Button(action: signIn) {
                Text("Přihlásit se")
            }
        }
    }

    private func signIn() {
        withAnimation {
            authenticated = true
        }
    }
}