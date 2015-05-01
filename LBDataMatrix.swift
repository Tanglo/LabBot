//
//  LBDataMatrix.swift
//  LabBot
//
//  Created by Lee Walsh on 9/04/2015.
//  Copyright (c) 2015 Dead Rubber Hand. All rights reserved.
//

import Cocoa

public class LBDataMatrix {
    private var variables = Array<String>()
    private var data = Array<Array<AnyObject>>()
    
    public convenience init(variableNames:[String], observations: [[AnyObject]]){
        self.init()
        let numVars = variableNames.count
        for obsArray in observations {
            var mutObsArray = changeArrayLength(obsArray, newLength: numVars)
            data.append(mutObsArray)
        }
        variables = variableNames
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
    
    public func numberOfObservations()->Int{
        return data.count
    }
    
    public func numberOfVariables()->Int{
        return variables.count
    }
    
    public func indexOfVariable(variable: String)->Int?{
        return find(self.variables, variable)
    }
    
    public func changeDataPoint(variable: String, observation: Int, newValue: Double){
        let varIndex = indexOfVariable(variable)
        if varIndex != nil {
            data[observation][varIndex!] = newValue
        }
    }
    
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

/*
-(DRHDataMatrix *)initWithRowArrays:(NSArray *)rowArrays;
+(DRHDataMatrix *)dataMatrixWithColumnArrays:(NSArray *)dataArrays __attribute__((deprecated));
+(DRHDataMatrix *)dataMatrixWithDataColumnArray:(NSArray *)dataArrays;
-(NSInteger)rowCount;
-(NSInteger)columnCount;
-(NSArray *)dataRowAtIndex:(NSInteger)index;
-(NSArray *)dataRowAtIndex:(NSInteger)index ForColumnsWithIndexes:(NSIndexSet *)columnIndexes;
-(NSArray *)dataRowAtIndex:(NSInteger)index ForColumnsWithNames:(NSArray *)nameArray;
-(NSInteger)indexOfDataColumnWithName:(NSString *)columnName;
-(NSIndexSet *)indexesOfDataColumnsWithNames:(NSArray *)nameArray;
-(DRHDataColumn *)dataColumnAtIndex:(NSInteger)index;
-(DRHDataColumn *)dataColumnWithName:(NSString *)name;
-(DRHDataMatrix *)dataMatrixByAddingDataColumn:(DRHDataColumn *)dataColumn;
-(DRHDataMatrix *)dataMatrixByInsertingColumn:(DRHDataColumn *)dataColumn AtIndex:(NSInteger)index __attribute__((deprecated));
-(DRHDataMatrix *)dataMatrixByInsertingDataColumn:(DRHDataColumn *)dataColumn AtIndex:(NSInteger)index;
-(DRHDataMatrix *)dataMatrixByRemovingColumnWithName:(NSString *)columnName;
-(void)shuffleRows;
*/