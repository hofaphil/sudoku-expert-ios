import Foundation

class Position: Equatable {

    var row: Int, column: Int, block: Int

    init(block: Int, row: Int, column: Int) {
        self.row = row
        self.column = column
        self.block = block
    }

    static func ==(a: Position, b: Position) -> Bool {
        a.row == b.row && a.column == b.column && a.block == b.block
    }
}
