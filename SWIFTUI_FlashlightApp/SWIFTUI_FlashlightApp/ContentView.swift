//
//  ContentView.swift
//  SWIFTUI_FlashlightApp
//
//  Created by michael on 06/08/2024.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @State private var isFlashlightOn = false
    
    var body: some View {
        VStack {
            Button(action: {toggleFlashlight()}, label: {
                Text(isFlashlightOn ? "Turn Off" : "Turn On")
                    .font(.largeTitle)
                    .padding()
                    .background(isFlashlightOn ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
        }
        .padding()
    }
    func toggleFlashlight() {
        isFlashlightOn.toggle()
        updateFlashlight()
    }
    func updateFlashlight() {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else { return }
        do {
            try device.lockForConfiguration()
            device.torchMode = isFlashlightOn ? .on : .off
            device.unlockForConfiguration()
        } catch {
            print("Torch could not be used")
        }
    }
}

#Preview {
    ContentView()
}
