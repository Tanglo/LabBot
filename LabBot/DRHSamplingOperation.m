//
//  DRHSamplingOperation.m
//  LabBot
//
//  Created by Lee Walsh on 13/01/2015.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import "DRHSamplingOperation.h"
#import "DRHDaqDevice.h"
//#import "DRHLabjackU6.h"
//#import "u6.h"

@implementation DRHSamplingOperation

-(id)init{
    if (self = [super init]) {
        executing = NO;
        finished = NO;
        
        daqDevice = nil;
        dataRecipient = nil;
    }
    return self;
}

-(DRHSamplingOperation *)initSamplingOperationWith:(DRHDaqDevice *)newDaqDevice And:(id)newDataRecipient{
    if (self = [super init]) {
        executing = NO;
        finished = NO;
        
        daqDevice = newDaqDevice;
        dataRecipient = newDataRecipient;
    }
    return self;
}

+(DRHSamplingOperation *)samplingOperationWith:(DRHDaqDevice *)newDaqDevice And:(id)newDataRecipient{
    return [[DRHSamplingOperation alloc] initSamplingOperationWith:newDaqDevice And:newDataRecipient];
}

-(BOOL)isConcurrent{
    return YES;
}

-(BOOL)isExecuting{
    return executing;
}

-(BOOL)isFinished{
    return finished;
}

- (void)main {
    @try {
        
        // Do the main work of the operation here.
        while (![self isCancelled])
            [self readData:nil];
        
        [self completeOperation];
        NSLog(@"Done.");
    }
    @catch(...) {
        // Do not rethrow exceptions.
    }
}

- (void)start {
    NSLog(@"Starting operation...");
    // Always check for cancellation before launching the task.
    if ([self isCancelled])
    {
        // Must move the operation to the finished state if it is canceled.
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    NSLog(@"Go!");
    // If the operation is not canceled, begin executing the task.
    [self willChangeValueForKey:@"isExecuting"];
    NSThread *samplingThread = [[NSThread alloc] initWithTarget:self selector:@selector(main) object:nil];
    [samplingThread setThreadPriority:0.75];
    [samplingThread start];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
    if (![daqDevice startStream]) {
        [daqDevice closeConnection];
        [self cancel];
    }
}

-(void)cancel{
    [super cancel];
}

- (void)completeOperation {
    NSLog(@"Completing operation.");
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    executing = NO;
    finished = YES;
    [daqDevice stopStream];
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

-(void)readData:(NSTimer *)timer{
    //    NSLog(@"New read.");
    NSArray *newData = [daqDevice readStreamData];
    [dataRecipient receiveData:newData];
}

@end
