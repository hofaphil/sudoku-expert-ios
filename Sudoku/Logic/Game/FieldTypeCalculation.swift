import Foundation
import SwiftUI

extension MainModel {
    
    func initFieldTypes() {
        for b in 0...8 {
            fieldTypes.append([])
            for r in 0...2 {
                fieldTypes[b].append([])
                for _ in 0...2 {
                    fieldTypes[b][r].append(FieldType.unselected)
                }
            }
        }
        setFieldColors()
    }
    
    func setFieldColors() {
        let showErrors = UserDefaults.standard.bool(forKey: Data.GAME_SHOW_ERRORS);
        let markNumbers = UserDefaults.standard.bool(forKey: Data.SETTINGS_MARK_NUMBERS);
        let markLines = UserDefaults.standard.bool(forKey: Data.SETTINGS_MARK_LINES)
        
        for b in 0...8 {
            for r in 0...2 {
                for c in 0...2 {
                    let pos = Position(block: b, row: r, column: c)
                    
                    if (showErrors && game.getNumber(position: pos).isError()) {
                        fieldTypes[b][r][c] = FieldType.error;
                        continue
                    }
                    
                    if let selected = selected {
                        if (selected == pos) {
                            fieldTypes[b][r][c] = FieldType.current
                            continue
                        }
                        
                        if (markNumbers && game.getNumber(position: pos).number != 0) {
                            if (game.getNumber(position: pos).number == game.getNumber(position: selected).number) {
                                fieldTypes[b][r][c] = FieldType.selected
                                continue
                            }
                        }
                        
                        if (markLines) {
                            if (MainModel.partnerBlockLookup[selected.block].contains(pos.block)) {
                                // it's a col-partner
                                if (pos.block >= selected.block + 3 || pos.block <= selected.block - 3) {
                                    if (pos.column == selected.column) {
                                        fieldTypes[b][r][c] = FieldType.selected
                                        continue
                                    }
                                }
                                
                                // its a row-partner
                                else if (pos.row == selected.row) {
                                    fieldTypes[b][r][c] = FieldType.selected
                                    continue
                                    
                                }
                            } else if (pos.block == selected.block) {
                                if (pos.column == selected.column || pos.row == selected.row) {
                                    fieldTypes[b][r][c] = FieldType.selected
                                    continue
                                }
                            }
                        }
                    }
                    
                    fieldTypes[b][r][c] = FieldType.unselected
                }
            }
        }
    }
}
