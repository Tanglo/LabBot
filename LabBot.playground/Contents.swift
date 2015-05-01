//: Playground - noun: a place where people can play

import Cocoa
import LabBot

var str = "Hello, playground"

var names = ["One","Two","Three"]
var data:[[AnyObject]] = [[1,3.0,5],[3,4.6,5],[2.6,7,38],[8436.34,28,939]]
var dataMatrix: LBDataMatrix
dataMatrix = LBDataMatrix(variableNames: names, observations: data)

