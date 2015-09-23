//
//  TARouteDetailViewController+TARouteElements.h
//  TransitApp
//
//  Created by Inam Abbas on 9/22/15.
//  Copyright © 2015 Inam Abbas. All rights reserved.
//

#import "TARouteDetailViewController.h"

@interface TARouteDetailViewController (TARouteElements)

/**
 Configure the route elements using segment data. The route elements can contain data 
 for both "Stop" and "Transport".
 @return The array of route elements after configuration
 */

- (NSArray *)configureRouteElements;

@end
