#!/bin/sh

#  cloneGenerator.sh
#  Sudoku
#
#  Created by Philipp Hofer on 24.03.22.
#  Copyright © 2022 Philipp Hofer. All rights reserved.

git clone git@github.com:hofaphil/sudoku-expert-generator.git Sudoku/Logic/temp
mkdir Sudoku/Logic/Generator
mv Sudoku/Logic/temp/src/*  Sudoku/Logic/Generator
rm -rf Sudoku/Logic/temp/
