//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let arr = [2, -1, 0, 5]

str = ""
for number in arr {
    str += " \(number)"
}

str

var str1 = ""
for (idx, number) in arr.enumerate() {
    str1 += " {\(idx), \(number)}"
}

str1


