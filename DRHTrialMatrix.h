//
//  DRHTrialMatrix.h
//  LabBot
//
//  Created by Lee Walsh on 14/04/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Foundation/Foundation.h>

//extern NSString * const DRHTrialMatrixVariableNamesKey;// = @"Variable names";
//extern NSString * const DRHTrialMatrixDataKey;// = @"Trial matrix data";
extern NSString * const DRHTrialMatrixFactorsKey;
extern NSString * const DRHTrialMatrixFactorNamesKey;

@interface DRHTrialMatrix : NSObject


+(NSArray *)shuffleArray:(NSArray *)array;
//+(NSDictionary *)randomisedTrialMatrixWithVariables:(NSDictionary *)matrixVariables;
//+(NSDictionary *)randomisedTrialMatrixWithFileAtURL:(NSURL *)URL;
+(NSDictionary *)randomisedTrialMatrixWithVariables:(NSDictionary *)matrixVariables AndRepetitions:(NSInteger)repetitions;
//+(NSDictionary *)randomisedTrialMatrixWithFileAtURL:(NSURL *)URL AndRepetitions:(NSInteger)repetitions;
+(NSDictionary *)randomisedTrialMatrixWithFactors:(NSDictionary *)factors AndRepetitions:(NSInteger)repetitions;

@end
