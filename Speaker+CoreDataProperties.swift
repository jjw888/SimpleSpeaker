//
//  Speaker+CoreDataProperties.swift
//  SimpleSpeaker
//
//  Created by John Weddell on 30/9/2022.
//
//

import Foundation
import CoreData


extension Speaker {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Speaker> {
        return NSFetchRequest<Speaker>(entityName: "Speaker")
    }

    @NSManaged public var speakerName: String?
    @NSManaged public var speakerDesc: String?

}

extension Speaker : Identifiable {

}
