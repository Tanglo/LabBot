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
/// An object to store a matrix of experimental variables.
@objc open class LBDataMatrix: NSObject, NSCoding {
    /// An array of the names of the experimental variables.
    fileprivate var variables: Array<String>
    
    /// A array of variables, each of which is an array of data points.  Each variable should be the same length.
    fileprivate var data: Array<Array<AnyObject>>
    
    public override init(){
        variables = Array<String>()
        data = Array<Array<AnyObject>>()
    }
    
    public convenience init(variableNames:[String], observations: [[AnyObject]]){
        self.init()
        let numVars = variableNames.count
        for obsArray in observations {
            let mutObsArray = changeArrayLength(obsArray, newLength: numVars)
            data.append(mutObsArray)
        }
        variables = variableNames
    }
    
    /** 
        Creates and returns an empty dataMatrix
    
        - returns: A newly created and empty dataMatrix object.
    */
    open class func dataMatrix() ->LBDataMatrix{
        return LBDataMatrix()
    }
    
    // MARK: NSCoding
    required public init?(coder aDecoder: NSCoder) {
        self.variables = aDecoder.decodeObject(forKey: "variables") as! [String]
        self.data = aDecoder.decodeObject(forKey: "data") as! [[AnyObject]]
    }
    
    open func encode(with aCoder: NSCoder) {
        aCoder.encode(variables, forKey: "variables")
        aCoder.encode(data, forKey: "data")
    }
    
    // MARK: Enforcing a rectangular matrix
    /**
        Creates a copy of an array at a new legnth while maintaining its contents.
    
        Contents outside the new size are discarded.
    
        - parameter array: The array that needs to change size.
        - parameter newLength: The length of the new array.
        - returns: A new array of the specified length that contains the contents of the sepcified array.
    */
    fileprivate func changeArrayLength(_ array:[AnyObject], newLength: Int)->[AnyObject] {
        var mutArray = array
        while mutArray.count > newLength {
            mutArray.removeLast()
        }
        while mutArray.count < newLength {
            mutArray.append(Double.nan as AnyObject)
        }
        return mutArray
    }
    
    // MARK: Getting data
    /**
        The number of observations (rows) in the receiver.
    
        - returns: The number of data rows, or observations, in the receiver.
    */
    open func numberOfObservations()->Int{
        return data.count
    }
    
    /**
        The number of variables (columns) in the receiver.
    
        - returns: The number of variables, or columns, in the receiver.
    */
    open func numberOfVariables()->Int{
        return variables.count
    }
    
    /**
        Gets the index of a nameed variable.
    
        - parameter variable: The name of the variable you want the index of.
        - returns: The index of the variable (column) within the receiver, or nil if no variable with that name exisits.
    */
    open func indexOfVariable(_ variable: String)->Int?{
        return self.variables.index(of: variable)
    }
    
    /**
        Gets the observation at a specified index.
    
        - parameter index: The index (row number) of the observation you want retrieved.
        - returns: Any array of the data points in the specified row of the receiver.
    */
    open func observationAtIndex(_ index: Int)->[AnyObject]{
        return data[index]
    }
    
    /**
        Gets the variable at a specified index.
    
        - parameter index: The index (column number) of the variable you want retrieved.
        - returns: Any array of the data points in the variable located at the specifed index of the receiver, or nil if there is no variable at the specified index.
    */
    open func variableAtIndex(_ index: Int)->[AnyObject]?{
        if index < variables.count {
            var varArray = Array<AnyObject>()
            for observation in data {
                varArray.append(observation[index])
            }
            return varArray
        }
        return nil
    }
    
    /**
        Gets the variable with the specified name.
    
        - parameter name: The name of the variable you want retrieved.
        - returns: Any array of the data points in the variable with the specified name, or nil uif the receiver does not contain a variable with that name.
    */
    open func variableWithName(_ name: String)->[AnyObject]?{
        let variableIndex = indexOfVariable(name)
        if variableIndex != nil {
            return variableAtIndex(variableIndex!)
        }
        return nil
    }
    
    // MARK: Adding data
    /**
        Appends an observation to the receivers.  The observation is padded or cropped to the width of the receiver.
    
        - parameter newObs: An array of the observation's data points.
    */
    open func appendObservation(_ newObs:[AnyObject]){
        data.append(self.changeArrayLength(newObs, newLength: self.variables.count))
    }
    
    /**
        Appends the variable to the receiver.  The variable is padded or cropped to the length of the receiver.
    
        - parameter newVariable: The name of the variable being appended.
        - parameter values: An array of the values in the new variable.
    */
    open func appendVariable(_ newVariable:String, values:[AnyObject]){
        self.variables.append(newVariable)
        let numObs = data.count
        let newValues = changeArrayLength(values, newLength: numObs)
        for i in 0..<numObs {
            data[i].append(newValues[i])
        }
    }
    
    // MARK: Changing data
    /**
        Changes a single existing data point within the receiver.
    
        - parameter variable: The name of the variable (column) containing the data point to be changed.
        - parameter observation: The index of the observation (row) containing the data point to be changed.
        - parameter newValue: The new value of the data point to be changed.
    */
    open func changeDataPoint(_ variable: String, observation: Int, newValue: AnyObject){
        let varIndex = indexOfVariable(variable)
        if varIndex != nil {
            data[observation][varIndex!] = newValue
        }
    }
    
    // MARK: Organising data
    /**
        Shuffles the observations (rows) of the receiver using the modern Fisher-Yates algorithm.
    */
    open func shuffleObservations(){
        var shuffledData = self.data
        let numObs = shuffledData.count
        for i in stride(from: numObs, through: 1, by: -1) {
            let j = Int(arc4random_uniform(UInt32(i)))
            let movedObs = shuffledData.remove(at: j)
   //         println("--\(movedObs)")
            shuffledData.insert(movedObs, at: i-1)
        }
        data = shuffledData
    }
    
    
    
    // MARK: Debuging methods
    /**
        Prints the contents of the receiver to the debugging console.
    */
    open func printDataMatrix(){
        var outStr = ""
        for varName in variables {
            outStr = outStr + "\(varName)\t"
        }
        print(outStr)
        for obsArray in data {
            outStr = ""
            for dataPt in obsArray {
                outStr += "\(dataPt)\t"
            }
            print(outStr)
        }
    }
}
