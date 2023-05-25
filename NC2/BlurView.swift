//
//  BlurView.swift
//  NC2
//
//  Created by Belinda Angelica on 21/05/23.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    var style : UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
