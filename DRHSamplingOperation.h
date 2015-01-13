//
//  DRHSamplingOperation.h
//  LabBot
//
//  Created by Lee Walsh on 13/01/2015.
//  Copyright (c) 2015 Dead Rubber Hand. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DRHDaqDevice;

@interface DRHSamplingOperation : NSOperation {
    BOOL executing;
    BOOL finished;
    
    DRHDaqDevice *labjack;
    id dataRecipient;
}
-(DRHSamplingOperation *)initSampleOperationWith:(DRHDaqDevice *)newLabjack And:(id)sender;
+(DRHSamplingOperation *)sampleOperationWith:(DRHDaqDevice *)newLabjack And:(id)sender;

@end
