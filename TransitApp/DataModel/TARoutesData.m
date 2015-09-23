//
//  TAData.m
//  TransitApp
//
//  Created by Inam Abbas on 9/17/15.
//  Copyright © 2015 Inam Abbas. All rights reserved.
//

#import "TARoutesData.h"

@implementation TARoutesData

- (instancetype)initWithRoutes:(NSArray *)routes providers:(NSDictionary *)providers
{
    self = [super init];
    if (self) {
        _routes = routes;
        _providers = providers;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithRoutes:nil providers:nil];
}

@end
