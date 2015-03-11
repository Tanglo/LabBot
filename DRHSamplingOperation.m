//
//  DRHSamplingOperation.m
//  LabBot
//
//  Created by Lee Walsh on 13/01/2015.
//  Copyright (c) 2015 Dead Rubber Hand. All rights reserved.
//

#import "DRHSamplingOperation.h"
#import "DRHLabjackU6.h"

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

-(DRHSamplingOperation *)initSamplingOperationWith:(DRHLabjackU6 *)newLabjack And:(id)sender{
    if (self = [super init]) {
        executing = NO;
        finished = NO;
        
        daqDevice = newLabjack;
        dataRecipient = sender;
    }
    return self;
}

+(DRHSamplingOperation *)samplingOperationWith:(DRHLabjackU6 *)newLabjack And:(id)sender{
    return [[DRHSamplingOperation alloc] initSamplingOperationWith:newLabjack And:sender];
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
        closeUSBConnection([(DRHLabjackU6 *)daqDevice handle]);
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
