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

// from www
//extension Binding {
//    func withDefaultValue<T>(defaultValue: T) -> Binding<T> where Value == Optional<T> {
//        let safeValue: T
//
//        if let unwrappedValue: T = self.wrappedValue { safeValue = unwrappedValue }
//        else { safeValue = defaultValue }
//
//        return SwiftUI.Binding.init(
//            get: { () -> T in return safeValue },
//            set: { (newValue) in self.wrappedValue = newValue })
//    }

//extension Binding {
//    func withDefaultValue<T>(defaultValue: T) -> Binding<T> where Value == Optional<T> {
//        Binding<T>(
//            get: { self.wrappedValue ?? defaultValue },
//            set: { newValue in self.wrappedValue = newValue }
////            set: { self.wrappedValue = $0 }
//        )
//    }
//}

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

