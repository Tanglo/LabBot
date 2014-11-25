//
//  DRHAudioPlayer.h
//  LabBot
//
//  Created by Lee Walsh on 24/07/2014.
//  Copyright (c) 2014 Dead Rubber Hand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

/*!
 @brief A class for loading and audio files and managing its playback.
 
 This class simplifies the loading and playing of audio files.  This task is identical in most projects and so in most cases it can be reduced to send a couple of messages to this class.  This class is based on the AVFoundation framework.
 */
@interface DRHAudioPlayer : NSObject {
    /// @brief The @c AVPlayer object that will be used to play the audio file.
    AVPlayer *audioPlayer;
    /// @brief An instance variable that tracks if this object is setup and ready to play.
    BOOL isReadyToPlay;
}

/*!
 * Initialises the receiver including loading the audio file from the specified URL and getting the receiver ready to play.
 * @param URL A URL that specifies a valid audio file.
 * @return An initialised @c DRHAudioPlayer object.
 */
-(DRHAudioPlayer *)initWithURL:(NSURL *)URL;

/*!
 * Create a new @c DRHAudioPlayer object and initialises it including loading the audio file from the specified URL and getting the receiver ready to play.
 * @param URL A URL that specifies a valid audio file.
 * @return An initialised @c DRHAudioPlayer object.
 */
+(DRHAudioPlayer *)audioPlayerWithURL:(NSURL *)URL;

/*!
 * Checks if the receiver is initialised and ready to play.
 * @return @c YES if the receiver is ready to play, else @c NO.
 */
-(BOOL)isReadyToPlay;

/*!
 * Begins playback of the receiver.
 */
-(void)play;

@end
