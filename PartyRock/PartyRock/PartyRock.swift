//
//  PartyRock.swift
//  PartyRock
//
//  Created by Ebubekir on 11/30/16.
//  Copyright © 2016 Ebubekir. All rights reserved.
//

import Foundation

class PartyRock {
    private var imageURL : String!
    private var videoURL : String!
    private var videoTitle : String!
    
    var getImageURL: String! {
        return self.imageURL
    }
    
    var getVideoURL: String! {
        return self.videoURL
    }
    
    var getVideoTitle: String! {
        return self.videoTitle
    }
    
    init(imageURL: String, videoURL: String, videoTitle: String){
        self.imageURL = imageURL
        self.videoURL = videoURL
        self.videoTitle = videoTitle
    }
}
