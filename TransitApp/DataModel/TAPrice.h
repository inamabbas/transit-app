//
//  TAPrice.h
//  TransitApp
//
//  Created by Inam Abbas on 9/16/15.
//  Copyright (c) 2015 Inam Abbas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TAPrice : NSObject

/**
 The cost of transportation
 */
@property (nonatomic, readonly) NSNumber *amount;

/**
 The currency used
 */
@property (nonatomic, readonly) NSString *currency;


/**
 Initializes a route price with provided data.
 @param dictionary The dataset contains all the information about price.
 @param error The error, if it encounter any problem initializing price with given data.
 @return The newly-initialized price request.
 */
- (instancetype)initWithJsonDictionary:(NSDictionary *)dictionary error:(NSError **)error NS_DESIGNATED_INITIALIZER;

@end