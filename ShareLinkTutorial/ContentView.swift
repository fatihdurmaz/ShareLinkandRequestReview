//
//  ContentView.swift
//  ShareLinkTutorial
//
//  Created by Fatih Durmaz on 15.01.2024.
//

import SwiftUI
import PhotosUI
import StoreKit

struct ContentView: View {
    
    let url = URL(string: "https://yuumamobile.com")!
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var image = Image(systemName: "photo.artframe")
    
    @AppStorage("startCount") private var startCount = 0
    @Environment(\.requestReview) var requesReview
 
 var body: some View {
     NavigationStack {
         VStack {
             List {
                 Section("General") {
                     Label(
                         title: { Text("Account Information") },
                         icon: { Image(systemName: "person.2") }
                     )
                     Label(
                         title: { Text("Notification") },
                         icon: { Image(systemName: "bell") }
                     )
                     Label(
                         title: { Text("Appearance") },
                         icon: { Image(systemName: "gearshape") }
                     )
                 }
                 .textCase(.none)
                 
                 Section {
                     
                     ShareLink("Paylaş",item: url)
                         .foregroundColor(.pink)
                     
                     PhotosPicker(selection: $selectedItem, matching: .images) {
                         Label("Select Photo", systemImage: "photo.badge.plus")
                             .foregroundColor(.blue)
                     }
                     .onChange(of: selectedItem) {
                         Task {
                             do {
                                 if let data = try await selectedItem?.loadTransferable(type: Image.self) {
                                     image = data
                                 }
                             } catch {
                                 print(error.localizedDescription)
                             }
                         }
                     }
                     
                     HStack {
                         ShareLink(item: image, preview: SharePreview("Image Caption", image: image)) {
                             Image(systemName: "square.and.arrow.up")
                                 .font(.title2)
                         }
                         
                         image
                             .resizable()
                             .scaledToFit()
                             .cornerRadius(8)
                             .shadow(radius: 4)
                         .frame(maxWidth: .infinity, maxHeight: 250)
                     }
                     .foregroundColor(.gray)
                 }
                 
             }
             .tint(.black)
             
         }
         .onAppear{
             startCount += 1
             if startCount % 3 == 0 {
                 requesReview()
             }
         }
         .navigationTitle("Settings")
     }
 }
}

#Preview {
 ContentView()
}

