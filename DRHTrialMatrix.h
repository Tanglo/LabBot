//
//  DRHTrialMatrix.h
//  LabBot
//
//  Created by Lee Walsh on 14/04/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const DRHTrialMatrixFactorsKey;
extern NSString * const DRHTrialMatrixFactorNamesKey;

@interface DRHTrialMatrix : NSObject <NSCoding>{
    NSArray *nameArray;
    NSArray *dataArray;
}
@property NSArray *nameArray;

-(DRHTrialMatrix *)initWithRowArrays:(NSArray *)rowArrays;
+(DRHTrialMatrix *)trialMatrixWithTrialArrays:(NSArray *)trialArrays;
-(NSArray *)trials;




//Old.  Might be deprecated.
+(NSArray *)arrayOfNanWithLength:(NSInteger)length;
+(NSArray *)linearArrayOfIntegersFrom:(NSInteger)start To:(NSInteger)end WithIncrement:(NSInteger)increment AndRepetitions:(NSInteger)repetitions;
+(NSArray *)linearArrayOfDoublesFrom:(CGFloat)start To:(CGFloat)end WithIncrement:(CGFloat)increment AndRepetitions:(NSInteger)repetitions;
+(NSArray *)arrayByRepeatingArray:(NSArray *)array WithRepetitions:(NSInteger)repetitions;
+(NSArray *)shuffleArray:(NSArray *)array;

+(NSDictionary *)randomisedTrialMatrixWithVariables:(NSDictionary *)matrixVariables AndRepetitions:(NSInteger)repetitions;
+(NSDictionary *)randomisedTrialMatrixWithFactors:(NSDictionary *)factors AndRepetitions:(NSInteger)repetitions;

@end
