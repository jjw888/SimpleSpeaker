//
//  SpeakerViewModel.swift
//  StrengthWorkouts
//
//  Created by John Weddell on 23/2/2022.
//

import CoreData

struct SpeakerViewModel {
    let context: NSManagedObjectContext
    var speaker: Speaker
    let persistenceController: PersistenceController

    init(persistenceController: PersistenceController, speaker: Speaker? = nil) {
        self.context = persistenceController.childViewContext()

        if let speaker = speaker {
            self.speaker = persistenceController.copyForEditing(of: speaker, in: context)
        } else {
            self.speaker = persistenceController.newTemporaryInstance(in: context)
        }

        self.persistenceController = persistenceController
    }

    func persistSpeaker() {
        persistenceController.persist(speaker)
    }
}

