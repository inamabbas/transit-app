//
//  TARoutesManager.m
//  TransitApp
//
//  Created by Inam Abbas on 9/16/15.
//  Copyright (c) 2015 Inam Abbas. All rights reserved.
//

#import "TARoutesParser.h"
#import "TARoute.h"
#import "TAProvider.h"
#import "TARoutesData.h"

@implementation TARoutesParser

+ (instancetype)sharedInstance
{
    static TARoutesParser *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TARoutesParser alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (TARoutesData *)parseRoutesData:(NSData *)data error:(NSError **)error
{
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:error];
    
    if (!parsedObject)
        return nil;
    
    NSMutableArray *routes = [[NSMutableArray alloc] init];
    for (NSDictionary *routeObj in parsedObject[@"routes"]) {
        TARoute *route = [[TARoute alloc] initWithJsonDictionary:routeObj error:error];
        
        if (!route)
            return nil;
        
        [routes addObject:route];
    }
    
    NSMutableDictionary *providers = [[NSMutableDictionary alloc] init];
    NSDictionary *providerAttributes = parsedObject[@"provider_attributes"];
    
    for (NSString *providerKey in providerAttributes) {
        NSString *displayName = providerKey;
        
        if (providerAttributes[providerKey][@"display_name"])
            displayName = providerAttributes[providerKey][@"display_name"];
        
        NSDictionary *providerAttribute = @{ @"display_name": displayName,
                                             @"provider_icon_url": providerAttributes[providerKey] };
        
        TAProvider *provider = [[TAProvider alloc] initWithJsonDictionary:providerAttribute error:error];
        
        if (!provider)
            return nil;
        
        providers[providerKey] = provider;
    }
    
    return [[TARoutesData alloc] initWithRoutes:routes providers:providers];
}


@end
