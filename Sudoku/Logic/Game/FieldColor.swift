import Foundation
import SwiftUI

extension MainModel {
    
    static let selectedColor = Color.primary
    static let lightSelectedColor = Color.dimgray
    static let unselectedColor = Color.white
    
    func initColorArray() {
        for b in 0...8 {
            colors.append([])
            for r in 0...2 {
                colors[b].append([])
                for _ in 0...2 {
                    colors[b][r].append(MainModel.unselectedColor)
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
                        colors[b][r][c] = Color.error;
                        continue
                    }
                    
                    if let selected = selected {
                        if (selected == pos) {
                            colors[b][r][c] = MainModel.selectedColor
                            continue
                        }
                        
                        if (markNumbers && game.getNumber(position: pos).number != 0) {
                            if (game.getNumber(position: pos).number == game.getNumber(position: selected).number) {
                                colors[b][r][c] = MainModel.lightSelectedColor
                                continue
                            }
                        }
                        
                        if (markLines) {
                            if (MainModel.partnerBlockLookup[selected.block].contains(pos.block)) {
                                // it's a col-partner
                                if (pos.block >= selected.block + 3 || pos.block <= selected.block - 3) {
                                    if (pos.column == selected.column) {
                                        colors[b][r][c] = MainModel.lightSelectedColor
                                        continue
                                    }
                                }
                                
                                // its a row-partner
                                else if (pos.row == selected.row) {
                                    colors[b][r][c] = MainModel.lightSelectedColor
                                    continue
                                    
                                }
                            } else if (pos.block == selected.block) {
                                if (pos.column == selected.column || pos.row == selected.row) {
                                    colors[b][r][c] = MainModel.lightSelectedColor
                                    continue
                                }
                            }
                        }
                    }
                    
                    colors[b][r][c] = MainModel.unselectedColor
                }
            }
        }
    }
}
