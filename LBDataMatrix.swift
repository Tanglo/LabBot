//
//  LBDataMatrix.swift
//  LabBot
//
//  Created by Lee Walsh on 9/04/2015.
//  Copyright (c) 2015 Dead Rubber Hand. All rights reserved.
//

import Cocoa

public class LBDataMatrix {
    private var data = Dictionary<String, [AnyObject]>()
    
    public convenience init(variableNames:[String], observations: [[AnyObject]]){
        self.init()
        let numVars = variableNames.count
        for i in 0..<numVars {
            data[variableNames[i]] = [AnyObject]()
            //I seem to have to interate over the colums to create variable arrays
            //  but how to I get the size of observations?
            
//            data[variableNames[i]] = observations[][i]
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