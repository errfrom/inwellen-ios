//
//  Localizable.swift
//  Inwellen
//
//  Created by Dzmitry Shuysky on 24.07.21.
//  Copyright © 2021 Inwellen. All rights reserved.
//

protocol Localizable {
    var stringsTableName: String { get }
    var localized: String { get }
    func localized(_ stringsKey: String) -> String
}

extension Localizable {

    func localized(_ stringsKey: String) -> String {
        return stringsKey.localized(tableName: stringsTableName)
    }

}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {

    var stringsTableName: String {
        return String(describing: Self.self)
    }

    var localized: String {
        return rawValue.localized(tableName: stringsTableName)
    }

}
