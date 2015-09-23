//
//  TAData.h
//  TransitApp
//
//  Created by Inam Abbas on 9/17/15.
//  Copyright © 2015 Inam Abbas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TARoutesData : NSObject

/**
 The array of parsed routes
 */
@property (nonatomic, readonly) NSArray *routes;

/**
 The array of routes providers
 */
@property (nonatomic, readonly) NSDictionary *providers;


/**
 Initializes this routes data with provided data.
 @param routes The array of routes
 @param providers the array of providers.
 @return The newly-initialized routes data.
 */
- (instancetype)initWithRoutes:(NSArray *)routes providers:(NSDictionary *)providers NS_DESIGNATED_INITIALIZER;

@end
