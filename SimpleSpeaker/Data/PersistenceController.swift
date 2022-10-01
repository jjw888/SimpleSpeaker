//
//  PersistenceController.swift
//  SimpleSpeaker
//
//  Created by John Weddell on 30/9/2022.
//

import SwiftUI
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let persistentContainer: NSPersistentContainer

    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "SimpleSpeaker")

        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy

        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func save() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Unable to commit changes to Persistent Controller")
            }
        }
    }

    func persist(_ object: NSManagedObject) {
        do {
            try object.managedObjectContext?.save()
        } catch {
            print("error saving speakerGroup in child context to parent: \(error.localizedDescription)")
        }
        
        if let parent = object.managedObjectContext?.parent {
            do {
                try parent.save()
            } catch {
                print("error saving speakerGroup to persistent store: \(error.localizedDescription)")
            }
        }

        
    }
 
    func childViewContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.parent = persistentContainer.viewContext
        return context
    }
    
    func copyForEditing<T: NSManagedObject>(of object: T,
                                            in context: NSManagedObjectContext) -> T {
        guard let object = (try? context.existingObject(with: object.objectID)) as? T else {
            fatalError("Requested a copy of a managed object that doesn't exist")
        }
        
        return object
    }

    func newTemporaryInstance<T: NSManagedObject>(in context: NSManagedObjectContext) ->T {
        return T(context: context)
    }
}

private struct PersistenceControllerKey: EnvironmentKey {
    static let defaultValue: PersistenceController = PersistenceController.shared
}

extension EnvironmentValues {
    var persistenceController: PersistenceController {
        get { self[PersistenceControllerKey.self] }
        set { self[PersistenceControllerKey.self] =  newValue }
    }
}
