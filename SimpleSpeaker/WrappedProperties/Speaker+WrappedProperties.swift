//
//  Speaker+WrappedProperties.swift
//  StrengthWorkouts
//
//  Created by John Weddell on 24/2/2022.
//

import Foundation

extension Speaker {
    var wrappedSpeakerName: String {
        speakerName ?? ""
    }
    
    var wrappedSpeakerDesc: String {
        speakerDesc ?? ""
    }
}
