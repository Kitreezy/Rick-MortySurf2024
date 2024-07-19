//
//  CellFramesScrollTargetBehavior.swift
//  Rick&Morty
//
//  Created by Artem Rodionov on 17.07.2024.
//

import SwiftUI
// Binds the scrollview element to the center of the screen
struct CellFramesScrollTargetBehavior: ScrollTargetBehavior {
    var cellFrames: CellFrames
    
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        let yProposed = target.rect.midY
        
        guard let nearestEntry = cellFrames
            .frames
            .min(by: {( $0.value.midY - yProposed ).magnitude < ( $1.value.midY - yProposed ).magnitude})
        else { return }
        
        target.rect.origin.y = nearestEntry.value.midY - 0.5 * target.rect.size.height
    }
}
