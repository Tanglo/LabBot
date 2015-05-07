//
//  DRHExperimentData.h
//  LabBot
//
//  Created by Lee Walsh on 11/08/2014.
//  Copyright (c) 2014 Lee David Walsh. All rights reserved.
//  This sofware is licensed under the The MIT License (MIT)
//  See: https://github.com/Tanglo/LabBot/blob/master/LICENSE.md
//

#import <Foundation/Foundation.h>
#import <LabBot/LabBot-Swift.h>

/*!
 @brief An root level object to store basic experimental data and tables of experimental variables.
 
 A @c DRHExperimentalData object is intended to be the top level model object in an experimental applcaition.  It will contain all experimental data.  A @c DRHExperimentalData object contains instance variables to store basic experiment details such name, data, session, etc and also contains one instance of @c DRHDataMatrix.  It is expected that most LabBot experiments will use a sub-class of @c DRHExperimentalData because each experiment is unique and will have it's own requirements.  This object is here to provde a base template to facilitate defining a LabBot experiment's root data object.
 */
@interface DRHExperimentData : NSObject <NSCoding>

/// @brief The name of the experiment.
@property NSString *experimentName;

/// @brief A string that uniquely identifies the experimental subject.
@property NSString *experimentSubject;

/// @brief The name or identifier for this experimental session.
@property NSString *experimentSession;

/// @brief The date this experiemntal session was run.
@property NSDate *experimentDate;

/// @brief The filename stem to use when experiemntal data files are created.
@property NSString *experimentFilenameStem;

/// @brief A dataMatrix object to store experimental variables.
@property LBDataMatrix *experimentDataMatrix;

@end
