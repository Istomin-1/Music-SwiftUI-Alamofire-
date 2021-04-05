//
//  CMTime + Extension.swift
//  Music(SwiftUI + Alamofire)
//
//  Created by Mikhail on 04.04.2021.
//

import Foundation
import AVKit


extension CMTime {
    
    func displayString() -> String {
        guard !CMTimeGetSeconds(self).isNaN else { return "" }
        let totalSecond = Int(CMTimeGetSeconds(self))
        let seconds = totalSecond % 60
        let minutes = totalSecond / 60
        let timeFormatString = String(format: "%2d:%02d", minutes, seconds)
        return timeFormatString
    }
}
