//
//  LinkShorter.swift
//  Sudoku
//
//  Created by Philipp Hofer on 23.03.21.
//  Copyright © 2021 Philipp Hofer. All rights reserved.
//

import Foundation

struct LinkShorter {

    static func getLink(id: String) -> String {
        var link = id;

        link = link.replacingOccurrences(of: "000000000", with: "h");
        link = link.replacingOccurrences(of: "00000000", with: "g");
        link = link.replacingOccurrences(of: "0000000", with: "f");
        link = link.replacingOccurrences(of: "000000", with: "e");
        link = link.replacingOccurrences(of: "00000", with: "d");
        link = link.replacingOccurrences(of: "0000", with: "c");
        link = link.replacingOccurrences(of: "000", with: "b");
        link = link.replacingOccurrences(of: "00", with: "a");

        link = link.replacingOccurrences(of: "01", with: "i");
        link = link.replacingOccurrences(of: "02", with: "j");
        link = link.replacingOccurrences(of: "03", with: "k");
        link = link.replacingOccurrences(of: "04", with: "l");
        link = link.replacingOccurrences(of: "05", with: "m");
        link = link.replacingOccurrences(of: "06", with: "n");
        link = link.replacingOccurrences(of: "07", with: "o");
        link = link.replacingOccurrences(of: "08", with: "p");
        link = link.replacingOccurrences(of: "09", with: "q");

        return link;
    }

    static func getId(link: String) -> String {
        var id = link;

        id = id.replacingOccurrences(of: "a", with: "00");
        id = id.replacingOccurrences(of: "b", with: "000");
        id = id.replacingOccurrences(of: "c", with: "0000");
        id = id.replacingOccurrences(of: "d", with: "00000");
        id = id.replacingOccurrences(of: "e", with: "000000");
        id = id.replacingOccurrences(of: "f", with: "0000000");
        id = id.replacingOccurrences(of: "g", with: "00000000");
        id = id.replacingOccurrences(of: "h", with: "000000000");

        id = id.replacingOccurrences(of: "i", with: "01");
        id = id.replacingOccurrences(of: "j", with: "02");
        id = id.replacingOccurrences(of: "k", with: "03");
        id = id.replacingOccurrences(of: "l", with: "04");
        id = id.replacingOccurrences(of: "m", with: "05");
        id = id.replacingOccurrences(of: "n", with: "06");
        id = id.replacingOccurrences(of: "o", with: "07");
        id = id.replacingOccurrences(of: "p", with: "08");
        id = id.replacingOccurrences(of: "q", with: "09");

        return id;
    }
}
