//
//  TARouteElement.h
//  TransitApp
//
//  Created by Inam Abbas on 9/22/15.
//  Copyright © 2015 Inam Abbas. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TARouteElementType) {
    /*
     Route element for stops during the traveling
     */
    TARouteElementTypeStop,
    
    /*
     Route element for transport during the traveling
     */
    TARouteElementTypeTransport,
};

@interface TARouteElement : NSObject

/*
 Type of route the element belongs to
 */
@property (nonatomic) TARouteElementType type;

/*
 Time at which the traveler reach this elemnt of route
 */
@property (nonatomic) NSDate *time;

/*
 The amount of time it takes to complete this part of route
 */
@property (nonatomic) NSTimeInterval duration;

/*
 Title of transport
 */
@property (nonatomic) NSString *title;

/*
 Detail, contains instructions or action traveler need to perform to complete this part of route
 */
@property (nonatomic) NSString *detailText;

@end