import Foundation
import SwiftUI

extension MainModel {
    
    func initFieldTypes() {
        for b in 0...8 {
            fieldTypes.append([])
            for r in 0...2 {
                fieldTypes[b].append([])
                for _ in 0...2 {
                    fieldTypes[b][r].append(FieldType())
                }
            }
        }
        setFieldTypes()
    }
    
    func setFieldTypes() {
        let showErrors = UserDefaults.standard.bool(forKey: Data.GAME_SHOW_ERRORS);
        let markNumbers = UserDefaults.standard.bool(forKey: Data.SETTINGS_MARK_NUMBERS);
        let markLines = UserDefaults.standard.bool(forKey: Data.SETTINGS_MARK_LINES)
        
        for b in 0...8 {
            for r in 0...2 {
                for c in 0...2 {
                    fieldTypes[b][r][c] = FieldType()
                    let pos = Position(block: b, row: r, column: c)
                    
                    fieldTypes[b][r][c].error = showErrors && game.getNumber(position: pos).isError()
                    
                    if let selected = selected {
                        if (selected == pos) {
                            fieldTypes[b][r][c].selected = true
                            continue
                        }
                        
                        if (markNumbers){
                            let fieldNumber = game.getNumber(position: pos).number;
                            let fieldNumberIsSameAsSelectedNumber = fieldNumber != 0 && fieldNumber == game.getNumber(position: selected).number
                            if (fieldNumberIsSameAsSelectedNumber) {
                                fieldTypes[b][r][c].coSelected = true
                                continue
                            }
                        }
                        
                        if (markLines) {
                            if (MainModel.partnerBlockLookup[selected.block].contains(pos.block)) {
                                // it's a col-partner
                                if (pos.block >= selected.block + 3 || pos.block <= selected.block - 3) {
                                    if (pos.column == selected.column) {
                                        fieldTypes[b][r][c].coSelected = true
                                    }
                                }
                                
                                // it's a row-partner
                                else if (pos.row == selected.row) {
                                    fieldTypes[b][r][c].coSelected = true
                                }
                            } else if (pos.block == selected.block) {
                                if (pos.column == selected.column || pos.row == selected.row) {
                                    fieldTypes[b][r][c].coSelected = true
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
