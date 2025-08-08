//
//  ErrorView.swift
//  AirLearnAssignment
//
//  Created by Aakash Narkar on 08/08/25.
//

import SwiftUI

struct ErrorView: View {
    let error: APIError
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 40))
                .foregroundColor(.red)
                .padding()
            
            Text(error.errorDescription ?? "Unknown error")
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}
