//
//  main.swift
//  XyzMatrix
//
//  Created by xuyz on 16/7/15.
//  Copyright © 2016年 xuyz. All rights reserved.
//

import Foundation

/*
 *test for matrix struct
 */



var lhsmatrix = Matrix(rows: 5,cols: 5)
var rhsmatrix = Matrix(rows: 5,cols: 5)
var i = 0

for row in 0 ..< lhsmatrix.rows {
    for col in 0 ..< lhsmatrix.cols {
        i += 1
        lhsmatrix[row,col] = Double(i)
        rhsmatrix[row,col] = Double(i)
    }
}

//test for multiplication
var result = Matrix(rows: 2,cols: 3)
result = lhsmatrix.mul(rhsmatrix)
// print(result)

//test for subMatrix
let submat = result.subMatrix(0, i1: 2, j0: 0, j1: 2)
print(submat)

//test for setMatrix

var setmat = Matrix(rows: 4,cols: 4)
setmat.setMatrix(0, i1: 2, j0: 0, j1: 2, matrix: submat)

print(setmat)

//test for identity matrix
let ident : Matrix
ident = Matrix.Identity(3)
print(ident)

//test for transpose matrix
var trans : Matrix
trans = setmat.transpose()
print(trans)

//test for matrix inverse
var inv : Matrix
inv = Matrix(rows: 2, cols: 2)
i = 0
for row in 0 ..< inv.rows {
    for col in 0 ..< inv.cols {
        i += 1
        inv[row,col] = Double(i)
    }
}
inv = inv.inv()
print(inv)

print("Hello, World!")

