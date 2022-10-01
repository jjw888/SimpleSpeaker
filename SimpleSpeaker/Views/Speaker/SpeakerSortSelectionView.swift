//
//  SpeakerSortSelectionView.swift
//  StrengthWorkouts
//
//  Created by John Weddell on 27/2/2022.
//

import SwiftUI

struct SpeakerSortSelectionView: View {
    @Binding var selectedSortItem: SpeakerSort
    
    let sortItems: [SpeakerSort]

    var body: some View {
        Menu {
            Picker("Sort by", selection: $selectedSortItem) {
                ForEach(sortItems, id: \.self) { sort in
                    Text("\(sort.sortName)")
                }
            }
        } label: {
            Label(
                "Sort",
                systemImage: "arrow.up.arrow.down")
        }
        .pickerStyle(.inline)
    }
}


struct SpeakerSort: Hashable, Identifiable {
    let id: Int
    let sortName: String
    let sortDescriptors: [SortDescriptor<Speaker>]

    static let sortTypes: [SpeakerSort] = [
        SpeakerSort(
            id: 0,
            sortName: "Name | Ascending",
            sortDescriptors: [SortDescriptor(\Speaker.speakerName, order: .forward)]),
        SpeakerSort(
            id: 1,
            sortName: "Name | Descending",
            sortDescriptors: [SortDescriptor(\Speaker.speakerName, order: .reverse)])
    ]

    static var `default`: SpeakerSort {
        sortTypes[UserDefaults.standard.integer(forKey: "speakerSortTypeKey")]
    }
}
