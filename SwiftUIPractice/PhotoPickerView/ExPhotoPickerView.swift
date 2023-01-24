//
//  ExPhotoPickerView.swift
//  SwiftUIPractice
//
//  Created by 임훈 on 2023/01/01.
//

import SwiftUI
import PhotosUI

struct ExPhotoPickerView: View {
    
    @State private var selectedItem: PhotosPickerItem?
    var body: some View {
        VStack {
            PhotosPicker(selection: $selectedItem, matching: .any(of: [.videos])) {
                Label("Select a photo", systemImage: "photo")
            }
            .tint(.brown)
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
        }
    }
}

struct ExPhotoPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ExPhotoPickerView()
    }
}
