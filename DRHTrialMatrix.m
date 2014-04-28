//
//  DRHTrialMatrix.m
//  LabBot
//
//  Created by Lee Walsh on 14/04/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import "DRHTrialMatrix.h"

//NSString * const DRHTrialMatrixVariableNamesKey = @"Variable names";
//NSString * const DRHTrialMatrixDataKey = @"Trial matrix data";
NSString * const DRHTrialMatrixFactorsKey = @"trialMatrixFactors";
NSString * const DRHTrialMatrixFactorNamesKey = @"trialMatrixFactorNames";


@implementation DRHTrialMatrix

+(NSArray *)shuffleArray:(NSArray *)array{
    
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:array];
    
    for(NSUInteger i = [array count]; i > 1; i--) {
        NSUInteger j = arc4random_uniform((uint32)i);
        [temp exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
    }
    
    return [NSArray arrayWithArray:temp];
    
}

+(NSDictionary *)randomisedTrialMatrixWithVariables:(NSDictionary *)matrixVariables AndRepetitions:(NSInteger)repetitions{
    //Check that all variables are the same length
    NSEnumerator *keyEnumerator = [matrixVariables keyEnumerator];
    NSMutableArray *variableCounts = [NSMutableArray array];
    NSMutableArray *variableNames = [NSMutableArray array];
    NSString *key = @"";
    while (key = [keyEnumerator nextObject]) {
        [variableCounts addObject:[NSNumber numberWithInteger:[[matrixVariables objectForKey:key]count]]];
        [variableNames addObject:key];
    }
    if ([variableCounts count] >1) {
        for (NSInteger i=1 ; i<[variableCounts count] ; i++) {
            if ([[variableCounts objectAtIndex:i] integerValue] != [[variableCounts objectAtIndex:i-1] integerValue]) {
                NSAlert *anAlert = [NSAlert alertWithMessageText:@"Error: Trial matrix variables are not of the same length." defaultButton:@"Ok I'll fix it" alternateButton:nil otherButton:nil informativeTextWithFormat:@"You made a mistake in your code.  The NSDictionary you sent to randomisedTrialMatrixWithVariables:AndRepetitions: is not valid"];
                [anAlert runModal];
                return nil;
            }
        }
    }
    
    //Layout the base matrix
    NSMutableDictionary *randomisedTrialMatrix = [NSMutableDictionary dictionary];
    [randomisedTrialMatrix setObject:variableNames forKey:DRHTrialMatrixFactorNamesKey];
    NSInteger numOfRows = [[variableCounts objectAtIndex:0] integerValue];
    NSMutableArray *mainTrialMatrixData = [NSMutableArray array];
    for (NSInteger i=0 ; i<numOfRows ; i++) {
        for (NSInteger j=0 ; j<repetitions ; j++) {
            NSEnumerator *variableEnumerator = [matrixVariables objectEnumerator];
            NSMutableArray *rowArray = [NSMutableArray array];
            NSArray *variableArray;
            while (variableArray = [variableEnumerator nextObject]) {
                [rowArray addObject:[variableArray objectAtIndex:i]];
            }
            [mainTrialMatrixData addObject:[NSArray arrayWithArray:rowArray]];
        }
    }
    [randomisedTrialMatrix setObject:[NSArray arrayWithArray:[DRHTrialMatrix shuffleArray:mainTrialMatrixData]] forKey:DRHTrialMatrixFactorsKey];
//    NSLog(@"Made it to the end");
    return randomisedTrialMatrix;
}

+(NSDictionary *)randomisedTrialMatrixWithFactors:(NSDictionary *)factors AndRepetitions:(NSInteger)repetitions{
    /*
     receives dictionary contraining two arrays
     DRHTrialMatrixFactors is an array of the factors and the values
     DRHTrialMatrixFactorNames is an array of the names of the factors
     */
    NSArray *factorNames = [factors objectForKey:DRHTrialMatrixFactorNamesKey];
    NSArray *factorValues = [factors objectForKey:DRHTrialMatrixFactorsKey];
    NSMutableArray *factorCounts = [NSMutableArray array];
    for (NSArray *currentFactor in factorValues) {
        [factorCounts addObject:[NSNumber numberWithInteger:[currentFactor count]]];
    }
    NSInteger numberOfFactors = [factorValues count];
    NSInteger totalNumOfTrials = 1;
    for (NSNumber *currentCount in factorCounts){
        totalNumOfTrials *= [currentCount integerValue];
    }
    totalNumOfTrials *= repetitions;
//    NSLog(@"Total number of factors is %ld",numberOfFactors);
//    NSLog(@"Total number of trials is %ld",totalNumOfTrials);
    
    NSMutableArray *fullFactors = [NSMutableArray array];
    NSInteger blockSize = repetitions;
    for (NSInteger i = numberOfFactors-1 ; i >= 0 ; i--) {
        NSMutableArray *newFactor = [NSMutableArray array];
        [fullFactors addObject:newFactor];
        NSInteger totalCount = 0;
        NSInteger currentFactorCount = [[factorCounts objectAtIndex:i] integerValue];
        while (totalCount < totalNumOfTrials) {
            for (NSInteger j = 0 ; j < currentFactorCount ; j++) {
                for (NSInteger k = 0 ; k < blockSize ; k++) {
                    [newFactor addObject:[[factorValues objectAtIndex:i] objectAtIndex:j]];
                    totalCount++;
                }
            }
        }
        blockSize *= [[factorCounts objectAtIndex:i] integerValue];
    }
//    NSLog(@"Number of fullFactors: %ld",[fullFactors count]);
    NSMutableArray *trialMatrix = [NSMutableArray array];
    for (NSInteger i=0 ; i<totalNumOfTrials ; i++) {
        NSMutableArray *rowArray = [NSMutableArray array];
        for (NSInteger j=[fullFactors count] -1; j>=0; j--) {
            [rowArray addObject:[[fullFactors objectAtIndex:j] objectAtIndex:i]];
        }
        [trialMatrix addObject:rowArray];
    }
    
/*    for (NSArray *currentFactor in fullFactors) {
        for (NSInteger i=0 ; i<totalNumOfTrials ; i++) {
            NSLog(@"%ld: %@",i,[currentFactor objectAtIndex:i]);
        }
    }*/
    NSDictionary *randomisedTrialMatrix = [NSDictionary dictionaryWithObjectsAndKeys:factorNames,DRHTrialMatrixFactorNamesKey,[DRHTrialMatrix shuffleArray:trialMatrix],DRHTrialMatrixFactorsKey, nil];
    
//    NSLog(@"The trial matrix is %ld rows by %ld columns",[trialMatrix count],[[trialMatrix objectAtIndex:0] count]);
/*    for (NSArray *rowArray in [randomisedTrialMatrix objectForKey:DRHTrialMatrixFactorsKey]) {
        NSString *rowString = @"";
        for (NSInteger i=0 ; i<[rowArray count] ; i++) {
            rowString = [rowString stringByAppendingString:[NSString stringWithFormat:@"%@\t",[rowArray objectAtIndex:i]]];
        }
        NSLog(@"%@",rowString);
    }*/
    
    return randomisedTrialMatrix;
}

@end
