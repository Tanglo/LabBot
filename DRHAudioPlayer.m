//
//  DRHAudioPlayer.m
//  LabBot
//
//  Created by Lee Walsh on 24/07/2014.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import "DRHAudioPlayer.h"

@implementation DRHAudioPlayer

-(DRHAudioPlayer *)initWithURL:(NSURL *)URL{
    if (self = [super init]) {
        isReadyToPlay = NO;
        audioPlayer = nil;
        AVURLAsset *audioAsset = [[AVURLAsset alloc] initWithURL:URL options:nil];
        [audioAsset loadValuesAsynchronouslyForKeys:@[@"tracks"] completionHandler:^(void) {
            dispatch_async(dispatch_get_main_queue(),
               ^{
                    NSError *anError = nil;
                   if ([audioAsset statusOfValueForKey:@"tracks" error:&anError] == AVKeyValueStatusLoaded){
                       audioPlayer = [AVPlayer playerWithPlayerItem:[AVPlayerItem playerItemWithAsset:audioAsset]];
                       [[audioPlayer currentItem] addObserver:self forKeyPath:@"status" options:0 context:nil];
                       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:[audioPlayer currentItem]];
                   } else {
                       NSString *errorString = [NSString stringWithFormat:@"Audio file with path %@ could not be loaded.",[[audioAsset URL] path]];
                       NSError *anError = [NSError errorWithDomain:errorString code:-1 userInfo:nil];
                       NSAlert *anAlert = [NSAlert alertWithError:anError];
                       [anAlert runModal];
                    }
               });
        }];
    }
    return self;
}

+(DRHAudioPlayer *)audioPlayerWithURL:(NSURL *)URL{
    return [[DRHAudioPlayer alloc] initWithURL:URL];
}

-(BOOL)isReadyToPlay{
    return isReadyToPlay;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        if ([(AVPlayerItem *)object status] == AVPlayerItemStatusReadyToPlay) {
            [self willChangeValueForKey:@"isReadyToPlay"];
            isReadyToPlay = YES;
            [self willChangeValueForKey:@"isReadyToPlay"];
        } else if ([(AVPlayerItem *)object status] == AVPlayerItemStatusFailed) {
            NSString *errorString = [NSString stringWithFormat:@"Audio file with path %@ could not be loaded.",[[(AVURLAsset *)[[audioPlayer currentItem] asset] URL] path]];
            NSError *anError = [NSError errorWithDomain:errorString code:-1 userInfo:nil];
            NSAlert *anAlert = [NSAlert alertWithError:anError];
            [anAlert runModal];
        }
    }
}

-(void)playerItemDidReachEnd:(NSNotification *)notification{
    [audioPlayer seekToTime:kCMTimeZero];
}

-(void)play{
    [audioPlayer play];
}

@end
