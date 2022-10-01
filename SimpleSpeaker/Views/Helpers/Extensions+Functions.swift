//
//  HelperExtensions.swift
//  MTT
//
//  Created by John Weddell on 26/3/2022.
//

import SwiftUI

// from Donny Wals book
extension Binding {
    func withDefaultValue<Default>(_ defaultValue: Default) -> Binding<Default> where Value == Default? {
        .init(
            get: { wrappedValue ?? defaultValue },
            set: { newValue in wrappedValue = newValue }
        )
    }
}

extension Optional where Wrapped == String {
    var _bound: String? {
        get { return self }
        set { self = newValue }
    }
    public var bound: String {
        get { return _bound ?? "" }
        set { _bound = newValue.isEmpty ? nil : newValue }
    }
}

