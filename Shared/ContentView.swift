//
//  ContentView.swift
//  Shared
//
//  Created by Alonso Diaz Candia on 29-10-22.
//

import SwiftUI

struct ContentView: View {
    @State private var bulbStatus = "unknown"
    @State private var fetching = false
    var body: some View {
        VStack {
            HStack (alignment: .center) {
                VStack {
                    Button("Dormitorio",
                           action: {
                                Task {
                                    await getJoke("dormitorio")
                                }
                    })
                }
            }
        }
    }
    func getJoke(_ type: String) async {
        let url = "http://localhost:5051/api/power/dormitorio"
        let apiService = APIService(urlString: url)
        fetching.toggle()
        defer {
            fetching.toggle()
        }
        do {
            let bulDecoder:BulbDecoder = try await apiService.getJSON()
            bulbStatus = bulDecoder.status
        } catch {
            bulbStatus = error.localizedDescription
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
