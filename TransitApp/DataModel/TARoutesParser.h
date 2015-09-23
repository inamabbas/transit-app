//
//  TARoutesManager.h
//  TransitApp
//
//  Created by Inam Abbas on 9/16/15.
//  Copyright (c) 2015 Inam Abbas. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TARoutesData;

@interface TARoutesParser : NSObject

/**
Return the shared instance of class
 */

+ (instancetype)sharedInstance;

/**
 Parse routes json data
 @param data Json data
 @param error Error if it encountered any problems during parsing
 @return The parsed routes data.
 */

- (TARoutesData *)parseRoutesData:(NSData *)data error:(NSError **)error;

@end
