//
//  BottomSheetPosition.swift
//
//  Created by Lucas Zischka.
//  Copyright © 2022 Lucas Zischka. All rights reserved.
//

import SwiftUI

public enum BottomSheetPosition: Equatable {
    // Hidden
    case hidden
    // Bottom - only show header content with dynamic size
    case dynamicBottom
    // Bottom - only show header content with realtive size
    case relativeBottom(CGFloat)
    // Bottom - only show header content with absolute size
    case absoluteBottom(CGFloat)
    case dynamicTop
    case relativeTop(CGFloat)
    case absoluteTop(CGFloat)
    // Height matching content size
    case dynamic
    // Height as percent
    case relative(CGFloat)
    // Height in pixel
    case absolute(CGFloat)
    
    var isHidden: Bool {
        switch self {
        case .hidden:
            return true
        default:
            return false
        }
    }
    
    var isBottom: Bool {
        switch self {
        case .dynamicBottom, .relativeBottom, .absoluteBottom:
            return true
        default:
            return false
        }
    }
    
    var isTop: Bool {
        switch self {
        case .dynamicTop, .relativeTop, .absoluteTop:
            return true
        default:
            return false
        }
    }
    
    func asScreenHeight(
        with geometry: GeometryProxy
    ) -> CGFloat? {
        switch self {
        case .hidden:
            return 0
        case .dynamic, .dynamicTop:
            return nil
        case .dynamicBottom:
            return geometry.size.height * 0.125
        case .relative(let value), .relativeBottom(let value), .relativeTop(let value):
            return geometry.size.height * value
        case .absolute(let value), .absoluteBottom(let value), .absoluteTop(let value):
            return value
        }
    }
    
    init(
        _ `case`: BottomSheetPosition
    ) {
        self = `case`
        switch self {
        case .hidden, .dynamic, .dynamicBottom, .dynamicTop:
            return
        case .relative(let value), .relativeBottom(let value), .relativeTop(let value):
            if value < 0 || value > 1 {
                fatalError(
                    "[BottomSheetPosition] .relative: The value must be between or equal to 0 and 1."
                )
            } else {
                return
            }
        case .absolute(let value), .absoluteBottom(let value), .absoluteTop(let value):
            if value < 0 {
                fatalError(
                    "[BottomSheetPosition] .absolute: The value must be greater than 0."
                )
            } else {
                return
            }
        }
    }
}