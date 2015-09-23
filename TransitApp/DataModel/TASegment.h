//
//  TASegment.h
//  TransitApp
//
//  Created by Inam Abbas on 9/16/15.
//  Copyright (c) 2015 Inam Abbas. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, TATravelMode) {
    TATravelModeWalking,
    TATravelModeSubway,
    TATravelModeBus,
    TATravelModeChange,
    TATravelModeSetup,
    TATravelModeDriving,
    TATravelModeParking,
    TATravelModeCycling,
};


@interface TASegment : NSObject

/**
 The name of transport used by current segment
 */
@property (nonatomic, readonly) NSString *name;

/**
Number of stops to reach destination
 */
@property (nonatomic, readonly) NSNumber *stopsCount;

/**
 Travel mode for transportation. i.e cycling, bus, subway etc
 */
@property (nonatomic, readonly) TATravelMode travelMode;

/**
 Contains the instruction about current route part. i.e direction of bus
 */
@property (nonatomic, readonly) NSString *segmentDescription;

/**
 Color for the layout presentation of current segment
 */
@property (nonatomic, readonly) NSString *color;

/**
 The icon for transportation used in the current segment
 */
@property (nonatomic, readonly) NSString *iconURL;

/**
 Encoded polyline string using google polyline algorithem format https://developers.google.com/maps/documentation/utilities/polylinealgorithm?hl=en
 */
@property (nonatomic, readonly) NSString *polyline;

/**
 The array of stops
 */
@property (nonatomic, readonly) NSArray *stops;

/**
 The time traveler reach this segment (part) of route and start
 */
@property (nonatomic, readonly) NSDate *startTime;

/**
 The time traveler reach the end of this segment (part) of route
 */
@property (nonatomic, readonly) NSDate *endTime;


/**
 Initializes this segment of route with provided data.
 @param dictionary The dataset contains all the information about segment.
 @param error The error, if it encounter any problem initializing the segment with given data.
 @return The newly-initialized segment of route.
 */
- (instancetype)initWithJsonDictionary:(NSDictionary *)dictionary error:(NSError **)error NS_DESIGNATED_INITIALIZER;

@end
