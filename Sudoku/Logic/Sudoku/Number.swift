//
//  Number.swift
//  Sudoku
//
//  Created by Philipp Hofer on 24.03.22.
//  Copyright © 2022 Philipp Hofer. All rights reserved.
//

import Foundation

class Number: Equatable, ObservableObject, Codable {

    var number: Int
    var solution: Int
    var notes = [Bool](repeating: false, count: 9)

    private(set) var isChangeable: Bool
    private(set) var isNotes: Bool

    init() {
        number = 0
        solution = 0

        isChangeable = false
        isNotes = false
    }

    init(number: Int, solution: Int, isChangeable: Bool) {
        self.number = number
        self.solution = solution

        self.isChangeable = isChangeable
        isNotes = false
    }

    func insert(number: Int, note: Bool) -> Bool {
        if (!isChangeable) {
            return true
        }

        if (note) {
            insertNote(number)
        } else {
            insertNumber(number)
        }
        return !isError()
    }

    private func insertNumber(_ number: Int) {
        if (number == self.number) {
            delete()
        } else {
            if (isNotes) {
                delete()
            }
            isNotes = false
            self.number = number
        }
    }

    private func insertNote(_ number: Int) {
        self.number = 0
        isNotes = true
        notes[number - 1] = !notes[number - 1]
    }

    func delete() {
        if (isChangeable) {
            number = 0
            notes = [Bool](repeating: false, count: 9)
        }
    }

    func checkNote(number: Int) {
        if (notes[number - 1]) {
            notes[number - 1] = false
        }
    }

    func isError() -> Bool {
        number != 0 && number != solution
    }

    static func ==(a: Number, b: Number) -> Bool {
        for i in 0..<9 {
            if (a.notes[i] != b.notes[i]) {
                return false;
            }
        }
        return a.number == b.number
            && a.solution == b.solution
            && a.isChangeable == b.isChangeable
            && a.isNotes == b.isNotes
    }
}
