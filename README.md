# swiftMatrix
a easy-use Matrix struct in Swift


## Usage

A pure Swift matrix struct

### Initiation

```swift
var lhsmatrix = Matrix(rows: 5,cols: 5)
var rhsmatrix = Matrix(rows: 5,cols: 5)  //init with zeors

```

### subscript
```swift
lhsmatrix[0,1] = 2.0
rhsmatrix[3,5] = 5.0
```

### plus and minus
```swift
var plusMatrix = Matrix(rows: 5,cols: 5)
var minusMatrix = Matrix(rows: 5,cols: 5)
plusMatrix = lhsmatrix.plus(rhsmatrix)
minusMatrix = Matrix(rows:5, cols: 5)
```

### multiplication
```swift
var mulMatrix = Matrix(rows: 5,cols: 5)
mulMatrix = lhsmatrix.mul(rhsmatrix)
```

###get a subMatrix
```swift
//  get a defined part of a matrix
//  i0 - Initial row index
//  i1 - Final row index
//  j0 - Initial column index
//  j1 - Final column index
let submat = lhsmatrix(0, i1: 2, j0: 0, j1: 2)// get a 3*3 subMatrix
```

###set a subMatrix
```swift
//set a part of a matrix using a small matrix
//  i0 - Initial row index
//  i1 - Final row index
//  j0 - Initial column index
//  j1 - Final column index
//  matrix - small matrix to use
rhsmatrix.setMatrix(0, i1: 2, j0: 0, j1: 2, matrix: submat)
```


### identity matrix

```swift
//test for identity matrix
let ident : Matrix
ident = Matrix.Identity(3)
print(ident)
```

### transpose matrix
```swift
//test for transpose matrix
var trans : Matrix
trans = setmat.transpose()
print(trans)


```
### matrix invers
```swift
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
```


