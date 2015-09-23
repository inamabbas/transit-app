//
//  TAStop.h
//  TransitApp
//
//  Created by Inam Abbas on 9/16/15.
//  Copyright (c) 2015 Inam Abbas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TAStop : NSObject

/**
 The name of the stop
 */
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSNumber *longitude;
@property (nonatomic, readonly) NSNumber *latitude;

/**
 The datetime of arrival on this stop
 */
@property (nonatomic, readonly) NSDate *dateTime;

/**
 Initializes this stop with provided data.
 @param dictionary The dataset contains all the information about stop.
 @param error The error, if it encounter any problem initializing the stop with given data.
 @return The newly-initialized stop of segment.
 */
- (instancetype)initWithJsonDictionary:(NSDictionary *)dictionary error:(NSError **)error NS_DESIGNATED_INITIALIZER;

@end
