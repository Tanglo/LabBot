//
//  LBDataMatrix.swift
//  LabBot
//
//  Created by Lee Walsh on 9/04/2015.
//  Copyright (c) 2015 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

//  Data is stored in an array of arrays.  Each sub array (row) is an observation and contains value for each variable.

import Cocoa

@objc public class LBDataMatrix {
    private var variables: Array<String>
    private var data: Array<Array<AnyObject>>
    
    public init(){
        variables = Array<String>()
        data = Array<Array<AnyObject>>()
    }
    
    public convenience init(variableNames:[String], observations: [[AnyObject]]){
        self.init()
        let numVars = variableNames.count
        for obsArray in observations {
            var mutObsArray = changeArrayLength(obsArray, newLength: numVars)
            data.append(mutObsArray)
        }
        variables = variableNames
    }
    
    public class func dataMatrix() ->LBDataMatrix{
        return LBDataMatrix()
    }
    
    private func changeArrayLength(array:[AnyObject], newLength: Int)->[AnyObject] {
        var mutArray = array
        while mutArray.count > newLength {
            mutArray.removeLast()
        }
        while mutArray.count < newLength {
            mutArray.append(Double.NaN)
        }
        return mutArray
    }
    
    // MARK: Getting data
    public func numberOfObservations()->Int{
        return data.count
    }
    
    public func numberOfVariables()->Int{
        return variables.count
    }
    
    public func indexOfVariable(variable: String)->Int?{
        return find(self.variables, variable)
    }
    
    public func observationAtIndex(index: Int)->[AnyObject]{
        return data[index]
    }
    
    public func variableAtIndex(index: Int)->[AnyObject]?{
        if index < variables.count {
            var varArray = Array<AnyObject>()
            for observation in data {
                varArray.append(observation[index])
            }
            return varArray
        }
        return nil
    }
    
    public func variableWithName(name: String)->[AnyObject]?{
        let variableIndex = indexOfVariable(name)
        if variableIndex != nil {
            return variableAtIndex(variableIndex!)
        }
        return nil
    }
    
    // MARK: Adding data
    public func appendObservation(newObs:[AnyObject]){
        data.append(self.changeArrayLength(newObs, newLength: self.variables.count))
    }
    
    public func appendVariable(newVariable:String){
        self.variables.append(newVariable)
        let numObs = data.count
        for i in 0..<numObs {
            data[i].append(Double.NaN)
        }
    }
    
    // MARK: Changing data
    public func changeDataPoint(variable: String, observation: Int, newValue: Double){
        let varIndex = indexOfVariable(variable)
        if varIndex != nil {
            data[observation][varIndex!] = newValue
        }
    }
    
    // MARK: Organising data
    public func shuffleObservations(){
        var shuffledData = self.data
        let numObs = shuffledData.count
        for i in stride(from: numObs, through: 1, by: -1) {
            let j = Int(arc4random_uniform(UInt32(i)))
            let movedObs = shuffledData.removeAtIndex(j)
   //         println("--\(movedObs)")
            shuffledData.insert(movedObs, atIndex: i-1)
        }
        data = shuffledData
    }
    
    
    
    // MARK: Debuging methods
    public func printDataMatrix(){
        var outStr = ""
        for varName in variables {
            outStr = outStr + "\(varName)\t"
        }
        println(outStr)
        for obsArray in data {
            outStr = ""
            for dataPt in obsArray {
                outStr += "\(dataPt)\t"
            }
            println(outStr)
        }
    }
}