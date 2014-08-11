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

__attribute__((deprecated))
@interface DRHTrialMatrix : NSObject <NSCoding>{
    NSArray *nameArray;
    NSArray *dataArray;
}
@property NSArray *nameArray;

-(DRHTrialMatrix *)initWithRowArrays:(NSArray *)rowArrays;
+(DRHTrialMatrix *)trialMatrixWithTrialArrays:(NSArray *)trialArrays;
-(NSArray *)trials;
-(NSInteger)count;
-(NSArray *)trialRowAtIndex:(NSInteger)index;
-(void)shuffleTrials;




//Old.  Might be deprecated.
+(NSArray *)arrayOfNanWithLength:(NSInteger)length __attribute__((deprecated));
+(NSArray *)linearArrayOfIntegersFrom:(NSInteger)start To:(NSInteger)end WithIncrement:(NSInteger)increment AndRepetitions:(NSInteger)repetitions __attribute__((deprecated));
+(NSArray *)linearArrayOfDoublesFrom:(CGFloat)start To:(CGFloat)end WithIncrement:(CGFloat)increment AndRepetitions:(NSInteger)repetitions __attribute__((deprecated));
+(NSArray *)arrayByRepeatingArray:(NSArray *)array WithRepetitions:(NSInteger)repetitions __attribute__((deprecated));
+(NSArray *)shuffleArray:(NSArray *)array __attribute__((deprecated));

+(NSDictionary *)randomisedTrialMatrixWithVariables:(NSDictionary *)matrixVariables AndRepetitions:(NSInteger)repetitions __attribute__((deprecated));
+(NSDictionary *)randomisedTrialMatrixWithFactors:(NSDictionary *)factors AndRepetitions:(NSInteger)repetitions __attribute__((deprecated));

@end
