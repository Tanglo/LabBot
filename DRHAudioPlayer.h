//
//  DRHAudioPlayer.h
//  LabBot
//
//  Created by Lee Walsh on 24/07/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface DRHAudioPlayer : NSObject {
    AVPlayer *audioPlayer;
    BOOL isReadyToPlay;
}

-(DRHAudioPlayer *)initWithURL:(NSURL *)URL;
-(BOOL)isReadyToPlay;
-(void)play;

@end
