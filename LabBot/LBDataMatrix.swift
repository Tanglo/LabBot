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
@objc public class LBDataMatrix: NSObject, NSCoding {
    /// An array of the names of the experimental variables.
    private var variables: Array<String>
    
    /// A array of variables, each of which is an array of data points.  Each variable should be the same length.
    private var data: Array<Array<AnyObject>>
    
    public override init(){
        variables = Array<String>()
        data = Array<Array<AnyObject>>()
    }
    
    /**
     Initialises an LBDataMatric object with an array of variable names and an array of observations arrays.
     
     The variableNames array sets the number of columns in the dataMatrix object.  So if observation rows are wider, they will be prined and if they are are narrow they will be padded.
     
     - parameter variableNames: An array of String that specifies the variable names for the LBDataMatrix.
     - parameter observations: An array of observations arrays, each of which is an array of AnyObject.  These observation arrays form the rows of the dataMatrix.
     - returns: A dataMatrix object initialised with the sepcified variable names and observation rows.
     */
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
     Initialises a dataMatrix from a specified comma separated value (.csv) file using the specified string encoding.
     
     The number of variables in set by the widest row in the .csv file.  If there are not enough variables names extras are set to VcolumnNumber.  Observation rows are padded with "" to maintaing the whole data set as Strings.
     If loading of the .csv file fails an error will be thrown.
     
     - parameter csvURL: A file URL that points to the csv file that will be loaded and used for initialisation.
     - parameter titles: Indicates if the first line of the .csv file should be used as variable names.  If not variableNames will be set to V0, V1, V2, etc
     - returns: A dataMatrix object initialised from the specified .csv file.  If an error is thrown an empty dataMatrix is returned.
     */
    public convenience init(csvURL: NSURL, titles: Bool) throws{
        var csvString: String
        do{
            csvString = try String(contentsOfURL: csvURL)
        } catch {
            throw error
        }
        self.init()
        var csvLines = csvString.componentsSeparatedByString("\n")
        var newVariables = Array<String>()
        var newData = Array<Array<AnyObject>>()
        if titles{
            newVariables = csvLines[0].componentsSeparatedByString(",")
            csvLines.removeFirst()
        }
        for line in csvLines {
            let observations = line.componentsSeparatedByString(",")
            newData.append(observations)
        }
        
        //find the longest observation row
        var columnCount = newVariables.count
        for row in newData{
            if row.count > columnCount{
                columnCount = row.count
            }
        }
        
        //pad variableNames and other observation rows out to that size
        while newVariables.count < columnCount {
            newVariables.append("V\(newVariables.count-1)")
        }
        for var row in newData{
            while row.count < columnCount{
                row.append("")
            }
        }
        variables = newVariables
        data = newData
    }
    
    /** 
        Creates and returns an empty dataMatrix
    
        - returns: A newly created and empty dataMatrix object.
    */
    public class func dataMatrix() ->LBDataMatrix{
        return LBDataMatrix()
    }
    
    // MARK: NSCoding
    required public init?(coder aDecoder: NSCoder) {
        self.variables = aDecoder.decodeObjectForKey("variables") as! [String]
        self.data = aDecoder.decodeObjectForKey("data") as! [[AnyObject]]
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(variables, forKey: "variables")
        aCoder.encodeObject(data, forKey: "data")
    }
    
    // MARK: Enforcing a rectangular matrix
    /**
        Creates a copy of an array at a new legnth while maintaining its contents.
    
        Contents outside the new size are discarded.
    
        - parameter array: The array that needs to change size.
        - parameter newLength: The length of the new array.
        - returns: A new array of the specified length that contains the contents of the sepcified array.
    */
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
    /**
        The number of observations (rows) in the receiver.
    
        - returns: The number of data rows, or observations, in the receiver.
    */
    public func numberOfObservations()->Int{
        return data.count
    }
    
    /**
        The number of variables (columns) in the receiver.
    
        - returns: The number of variables, or columns, in the receiver.
    */
    public func numberOfVariables()->Int{
        return variables.count
    }
    
    /**
        Gets the index of a nameed variable.
    
        - parameter variable: The name of the variable you want the index of.
        - returns: The index of the variable (column) within the receiver, or nil if no variable with that name exisits.
    */
    public func indexOfVariable(variable: String)->Int?{
        return self.variables.indexOf(variable)
    }
    
    /**
        Gets the observation at a specified index.
    
        - parameter index: The index (row number) of the observation you want retrieved.
        - returns: Any array of the data points in the specified row of the receiver.
    */
    public func observationAtIndex(index: Int)->[AnyObject]{
        return data[index]
    }
    
    /**
        Gets the variable at a specified index.
    
        - parameter index: The index (column number) of the variable you want retrieved.
        - returns: Any array of the data points in the variable located at the specifed index of the receiver, or nil if there is no variable at the specified index.
    */
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
    
    /**
        Gets the variable with the specified name.
    
        - parameter name: The name of the variable you want retrieved.
        - returns: Any array of the data points in the variable with the specified name, or nil uif the receiver does not contain a variable with that name.
    */
    public func variableWithName(name: String)->[AnyObject]?{
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
    public func appendObservation(newObs:[AnyObject]){
        data.append(self.changeArrayLength(newObs, newLength: self.variables.count))
    }
    
    /**
        Appends the variable to the receiver.  The variable is padded or cropped to the length of the receiver.
    
        - parameter newVariable: The name of the variable being appended.
        - parameter values: An array of the values in the new variable.
    */
    public func appendVariable(newVariable:String, values:[AnyObject]){
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
    public func changeDataPoint(variable: String, observation: Int, newValue: AnyObject){
        let varIndex = indexOfVariable(variable)
        if varIndex != nil {
            data[observation][varIndex!] = newValue
        }
    }
    
    // MARK: Organising data
    /**
        Shuffles the observations (rows) of the receiver using the modern Fisher-Yates algorithm.
    */
    public func shuffleObservations(){
        var shuffledData = self.data
        let numObs = shuffledData.count
        for i in numObs.stride(through: 1, by: -1) {
            let j = Int(arc4random_uniform(UInt32(i)))
            let movedObs = shuffledData.removeAtIndex(j)
   //         println("--\(movedObs)")
            shuffledData.insert(movedObs, atIndex: i-1)
        }
        data = shuffledData
    }
    
    
    
    // MARK: Debuging methods
    /**
        Prints the contents of the receiver to the debugging console.
    */
    public func printDataMatrix(){
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