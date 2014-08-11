//
//  DRHTrialArray.h
//  LabBot
//
//  Created by Lee Walsh on 23/07/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Foundation/Foundation.h>

__attribute__((deprecated))
@interface DRHTrialArray : NSObject <NSCoding>{
    NSString *trialsArrayName;
    NSArray *trialData;
}
@property NSString *trialsArrayName;

-(DRHTrialArray *)initWithName:(NSString *)name AndArray:(NSArray *)array;
-(NSArray *)trials;
-(NSInteger)count;
-(id)trialAtIndex:(NSInteger)index;
//+(DRHTrialArray *)trialArrayWithName:(NSString *)name;
+(DRHTrialArray *)trialArrayWithName:(NSString *)name AndArray:(NSArray *)array;
+(DRHTrialArray *)trialArrayWithName:(NSString *)name OfNanWithLength:(NSInteger)length;
+(DRHTrialArray *)linearTrialArrayWithName:(NSString *)name OfIntegersFrom:(NSInteger)start To:(NSInteger)end WithIncrement:(NSInteger)increment AndRepetitions:(NSInteger)repetitions;
+(DRHTrialArray *)linearTrialArrayWithName:(NSString *)name OfDoublesFrom:(CGFloat)start To:(CGFloat)end WithIncrement:(CGFloat)increment AndRepetitions:(NSInteger)repetitions;
+(DRHTrialArray *)trialArrayWithName:(NSString *)name ByRepeatingArray:(NSArray *)array WithRepetitions:(NSInteger)repetitions;
+(DRHTrialArray *)shuffledTrialArrayWithName:(NSString *)name And:(NSArray *)array;

@end
