//
//  TAProvider.h
//  TransitApp
//
//  Created by Inam Abbas on 9/16/15.
//  Copyright (c) 2015 Inam Abbas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TAProvider : NSObject

/**
 Title of service provider
 */
@property (nonatomic, readonly) NSString *title;

/**
Icon url of service provider
 */
@property (nonatomic, readonly) NSString *iconURL;


/**
 Initializes the class with provider's data
 @param dictionary Providers data
 @param error if it encountered any problems initializing
 @return The newly-initialized routes provider.
 */

- (instancetype)initWithJsonDictionary:(NSDictionary *)dictionary error:(NSError **)error NS_DESIGNATED_INITIALIZER;    

@end
