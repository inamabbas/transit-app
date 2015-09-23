//
//  TARoute.h
//  TransitApp
//
//  Created by Inam Abbas on 9/16/15.
//  Copyright (c) 2015 Inam Abbas. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TAPrice;

@interface TARoute : NSObject

/*
 Type of route itself, it can be via public transport, car sharing, bike taxi etc
 */
@property (nonatomic, readonly) NSString *type;

/*
 The provider of transport on current route
 */
@property (nonatomic, readonly) NSString *provider;

/*
Route start time
 */
@property (nonatomic, readonly) NSDate *startTime;

/*
 Route end time
 */
@property (nonatomic, readonly) NSDate *endTime;

/*
 It contains all the segments in the route. Route can be in different segments(parts).
 */
@property (nonatomic, readonly) NSArray *segments;

/*
 The price of route. How much it cost to complete the route.
 */
@property (nonatomic, readonly) TAPrice *price;

/**
 Initializes a route with provided data.
 @param dictionary The dataset contains all the information about route.
 @param error The error, if it encounter any problem initializing the route with given data.
 @return The newly-initialized route request.
 */
- (instancetype)initWithJsonDictionary:(NSDictionary *)dictionary error:(NSError **)error NS_DESIGNATED_INITIALIZER;

@end
