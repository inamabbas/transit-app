//
//  TAProvider.m
//  TransitApp
//
//  Created by Inam Abbas on 9/16/15.
//  Copyright (c) 2015 Inam Abbas. All rights reserved.
//

#import "TAProvider.h"
#import "TAParsingUtil.h"

@implementation TAProvider

- (instancetype)initWithJsonDictionary:(NSDictionary *)dictionary error:(NSError **)error
{
    self = [super init];
    if (self) {
        _title = NULL_TO_NIL(dictionary[@"display_name"]);
        _iconURL = NULL_TO_NIL(dictionary[@"provider_icon_url"]);
    }
    return self;
}


- (instancetype)init
{
    return [self initWithJsonDictionary:nil error:nil];
}

@end

