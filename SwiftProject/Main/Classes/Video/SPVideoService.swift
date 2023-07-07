//
//  SPVideoService.swift
//  SwiftProject
//
//  Created by flower on 2023/7/7.
//

import Foundation
import SJVideoPlayer

class SPVideoService:NSObject{
    
    lazy  var videoPlayer: SJVideoPlayer = {
        let video = SJVideoPlayer()
        return video
    }()
}
