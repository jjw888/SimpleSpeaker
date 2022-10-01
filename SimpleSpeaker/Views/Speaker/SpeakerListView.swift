//
//  SpeakerListView.swift
//  SimpleSpeaker
//
//  Created by John Weddell on 30/9/2022.
//

import SwiftUI

struct SpeakerListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.persistenceController) var persistenceController
    
    @State private var selectedSort = SpeakerSort.default
    @State private var isShowingSortScreen = false
    @State private var addNewSpeaker = false
    @State private var mode: EditMode = .inactive
    @State private var isSortActive = false
    
//    @State private var selectedSpeaker = ""
    
    let color: Color
    
    @FetchRequest(
        sortDescriptors: SpeakerSort.default.sortDescriptors
    ) private var speakerList: FetchedResults<Speaker>
    
    var body: some View {
        ZStack {
            color
                .edgesIgnoringSafeArea(.all)
            
            VStack() {
                SpeakerHeaderCompactView()
                
                List {
                    if speakerList.count == 0  {
                        Text("No speakers found")
                            .foregroundColor(.red)
                    } else {
                        ForEach(speakerList, id: \.self) { speaker in
                            NavigationLink(destination: SpeakerEditView(
                                speakerViewModel: SpeakerViewModel(
                                    persistenceController: persistenceController,
                                    speaker: speaker),
                                draftSpeakerName: speaker.wrappedSpeakerName,
                                color: color
                            )
                            ) {
                                if sizeClass == .compact {
                                    SpeakerListCompactView(speaker: speaker)
                                } else {
                                    SpeakerListRegularView(speaker: speaker)
                                }
                            }
                        }
                        .onDelete(perform: onDelete)
                    }
                }
            }
            .navigationTitle("Speakers")
            .padding()
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    EditButton()
                    sortButton
                    addButton
                }
            }
        }
        .environment(\.editMode, $mode)
    }
    
    func onDelete(at offsets: IndexSet) {
        for offset in offsets {
            let speaker = speakerList[offset]
            managedObjectContext.delete(speaker)
        }
        
        persistenceController.save()
    }
}

    
extension SpeakerListView {
    private var sortButton: some View {
        SpeakerSortSelectionView(
            selectedSortItem: $selectedSort,
            sortItems: SpeakerSort.sortTypes)
            .onChange(of: selectedSort) { _ in
                speakerList.sortDescriptors = selectedSort.sortDescriptors
                UserDefaults.standard.set(self.selectedSort.id, forKey: "speakerSortTypeKey")
            }
            .disabled(mode == .active ? true : false)
    }
    
    private var addButton: some View {
        NavigationLink("\(Image(systemName: "plus"))") {
            SpeakerEditView(
                speakerViewModel: SpeakerViewModel(persistenceController: persistenceController),
                    draftSpeakerName: "",
                color: color)
        }
        .disabled(mode == .active ? true : false)
    }
}
