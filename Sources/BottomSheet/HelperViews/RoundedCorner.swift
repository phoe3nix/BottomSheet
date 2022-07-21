//
//  RoundedCorner.swift
//
//  Created by Lucas Zischka.
//  Copyright © 2021-2022 Lucas Zischka. All rights reserved.
//

import SwiftUI

private struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

internal extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
		clipShape(RoundedRectangle(cornerRadius: radius, style: .circular))
    }
}

struct RoundedCorner_Previews: PreviewProvider {
    static var previews: some View {
        Rectangle()
            .cornerRadius(32, corners: [.topLeft, .topRight])
    }
}
