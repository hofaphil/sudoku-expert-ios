//
// Created by Philipp Hofer on 10.04.22.
// Copyright (c) 2022 Philipp Hofer. All rights reserved.
//

import XCTest
@testable import Sudoku

class LinkShorterTests: XCTestCase {

    func test() {
        let link = "02303049923333234322031030200000003040230420402302012303023";
        let shortened = LinkShortener.getId(link: link);

        XCTAssertEqual(link, LinkShortener.getId(link: shortened));
    }
}
