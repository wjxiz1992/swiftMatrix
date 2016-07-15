//
//  Matrix.swift
//  XyzMatrix
//
//  Created by xuyz on 16/7/15.
//  Copyright © 2016年 xuyz. All rights reserved.
//

import Foundation

import Accelerate
struct Matrix {
    var rows: Int
    var cols: Int
    var grid: [[Double]]
    
    //init with Zero
    init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        grid = Array<Array<Double>>(count: rows,repeatedValue: Array<Double>(count: cols,repeatedValue: 0.0))
    }
    
    func indexIsValidForMatrix(row: Int, col: Int) -> Bool {
        return row >= 0 && row < rows && col >= 0 && col < cols
    }
    
    
    //get an indentity matrix
    static func Identity(length: Int) -> Matrix {
        var identity = Matrix(rows:length, cols: length)
        for i in 0 ..< length {
            identity[i,i] = 1
        }
        return identity
    }
    
    //get a transpose matrix
    func transpose() -> Matrix {
        var trans = Matrix(rows: self.cols,cols: self.rows)
        for row in 0 ..< trans.rows {
            for col in 0 ..< trans.cols {
                trans.grid[row][col] = self.grid[col][row]
            }
        }
        return trans
    }
    
    //using like matrix[0,1] = 2.0
    //           matrix[3,5] = 5.0
    subscript(row: Int, col: Int) -> Double {
        get{
            assert(indexIsValidForMatrix(row, col: col),"Index out of range")
            return grid[row][col]
        }
        set {
            assert(indexIsValidForMatrix(row, col: col),"Index out of range")
            grid[row][col] = newValue
        }
        
    }
    
    //get a SubMatrix by
    //  i0 - Initial row index
    //  i1 - Final row index
    //  j0 - Initial column index
    //  j1 - Final column index
    func subMatrix(i0: Int,i1: Int,j0: Int, j1: Int) -> Matrix {
        assert(indexIsValidForMatrix(i0, col: j0),"Index out of range")
        assert(indexIsValidForMatrix(i1, col: j1),"Index out of range")
        assert(i0 <= i1 && j0 <= j1, "Wrong index")
        let subRows = i1 - i0 + 1
        let subCols = j1 - j0 + 1
        var subMatrix = Matrix(rows : subRows, cols: subCols)
        //get value one by one
        for row in i0 ... i1 {
            for col in j0 ... j1 {
                subMatrix.grid[row - i0][col - j0] = self.grid[row][col]
            }
        }
        
        return subMatrix
    }
    
    //set a part of a matrix using a small matrix
    //  i0 - Initial row index
    //  i1 - Final row index
    //  j0 - Initial column index
    //  j1 - Final column index
    //  matrix - Matrix to use
    mutating func setMatrix(i0: Int, i1: Int, j0: Int, j1: Int, matrix: Matrix) -> Void {
        assert((i1-i0+1) == matrix.rows && (j1-j0+1) == matrix.cols, "matrix not fit")
        for row in i0...i1 {
            for col in j0...j1 {
                self.grid[row][col] = matrix.grid[row-i0][col-j0]
            }
        }
    }
    
    //multiplication.
    func mul(matrix: Matrix) -> Matrix {
        assert(self.cols == matrix.rows, "mul can't be executed")
        let newRows = self.rows
        let newCols = matrix.cols
        var newMatrix = Matrix(rows: newRows,cols: newCols)
        
        for rowLhs in 0 ..< self.rows {
            for colLhs in 0 ..< self.cols {
                for colRhs in 0 ..< matrix.cols {
                    newMatrix.grid[rowLhs][colRhs] += self.grid[rowLhs][colLhs] * matrix.grid[colLhs][colRhs]
                }
            }
        }
        return newMatrix
    }
    
    func plus(matrix: Matrix) -> Matrix {
        assert(self.rows == matrix.rows && self.cols == matrix.cols,"matrix not fit")
        var result = Matrix(rows: self.rows,cols: self.cols)
        for row in 0 ..< self.rows {
            for col in 0 ..< self.cols {
                result[row,col] = self[row,col] + matrix[row,col]
            }
        }
        return result
    }
    
    func minus(matrix: Matrix) -> Matrix {
        assert(self.rows == matrix.rows && self.cols == matrix.cols,"matrix not fit")
        var result = Matrix(rows: self.rows,cols: self.cols)
        for row in 0 ..< self.rows {
            for col in 0 ..< self.cols {
                result[row,col] = self[row,col] - matrix[row,col]
            }
        }
        return result
    }
    
    func inv() -> Matrix {
        precondition(self.rows == self.cols, "Matrix must be square")
        
        var results = self
        var grid = [Double]()
        for row in 0 ..< results.rows {
            for col in 0 ..< results.cols {
                grid.append(self.grid[row][col])
            }
        }
        
        
        var ipiv = [__CLPK_integer](count: self.rows * self.rows, repeatedValue: 0)
        var lwork = __CLPK_integer(self.cols * self.cols)
        var work = [CDouble](count: Int(lwork), repeatedValue: 0.0)
        var error: __CLPK_integer = 0
        var nc = __CLPK_integer(self.cols)
        
        dgetrf_(&nc, &nc, &(grid), &nc, &ipiv, &error)
        dgetri_(&nc, &(grid), &nc, &ipiv, &work, &lwork, &error)
        
        assert(error == 0, "Matrix not invertible")
        
        for row in 0 ..< results.rows {
            for col in 0 ..< results.cols {
                results.grid[row][col] = grid[row * self.cols + col]
            }
        }
        
        
        return results
    }
    
    
    
    
}
