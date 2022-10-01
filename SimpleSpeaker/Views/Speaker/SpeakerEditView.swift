//
//  EditSpeakerView.swift
//  StrengthWorkouts
//
//  Created by John Weddell on 24/2/2022.
//

import SwiftUI

struct SpeakerEditView: View {
    @Environment(\.dismiss) var dismiss

    @State var speakerViewModel: SpeakerViewModel
    @State var draftSpeakerName: String?

    let color: Color

    let navigationTitleAdd = "Add New Speaker"
    let navigationTitleEdit = "Edit Speaker"
    
    var body: some View {
        ZStack {
            color
                .edgesIgnoringSafeArea(.all)
            
            Form {
                addName
                addDescription
            }
            .navigationTitle(speakerViewModel.speaker.speakerName == nil ? navigationTitleAdd : navigationTitleEdit)
            .cornerRadius(10)
            .padding()
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    saveButton
                }
            }
        }
    }
    
    func saveSpeakerChanges() {
        speakerViewModel.speaker.speakerName = draftSpeakerName
        speakerViewModel.persistSpeaker()
    }
}

extension SpeakerEditView {
    private var addName: some View {
        HStack {
            Text("Name:")
            Spacer()
            TextField("Speaker name",
//                text: $speakerViewModel.speaker.speakerName.withDefaultValue(""))
                  text: $draftSpeakerName.withDefaultValue(""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    
    private var addDescription: some View {
        HStack {
            Text("Description:")
            Spacer()
            TextField("Speaker description",
                text: $speakerViewModel.speaker.speakerDesc.withDefaultValue(""))
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    
    private var saveButton: some View {
        Button(
            action: {
                self.saveSpeakerChanges()
                dismiss() },
            label: { Image(systemName: "square.and.arrow.down") }
        )
        .disabled(
            draftSpeakerName == ""
        )
    }
}

