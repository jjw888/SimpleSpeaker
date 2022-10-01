//
//  SpeakerDataViews.swift
//  SimpleSpeaker
//
//  Created by John Weddell on 30/9/2022.
//

import SwiftUI

struct SpeakerHeaderCompactView: View {
    var body: some View {
        HStack {
            Text("Speaker")
                .padding(.leading, 40)
            Text("Description")
                .padding(.leading, 50)
            Spacer()
        }
        .font(.headline)
    }
}

struct SpeakerListCompactView: View {
    @ObservedObject var speaker: Speaker
    
    var body: some View {
        HStack(spacing: 0) {
            Text(speaker.wrappedSpeakerName)
            Text(speaker.wrappedSpeakerDesc)
                .padding(.leading, 90)
            Spacer()
        }
    }
}


struct SpeakerListRegularView: View {
    @ObservedObject var speaker: Speaker
    
    var body: some View {
        VStack {
            HStack {
                Text(speaker.wrappedSpeakerName)
                Text(speaker.wrappedSpeakerDesc)
                    .padding(.leading, 85)
            }
        }
    }
}

