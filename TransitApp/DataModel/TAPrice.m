//
//  TAPrice.m
//  TransitApp
//
//  Created by Inam Abbas on 9/16/15.
//  Copyright (c) 2015 Inam Abbas. All rights reserved.
//

#import "TAPrice.h"
#import "TAParsingUtil.h"

@implementation TAPrice

- (instancetype)initWithJsonDictionary:(NSDictionary *)dictionary error:(NSError **)error
{
    self = [super init];
    if (self) {
        _currency = NULL_TO_NIL(dictionary[@"currency"]);
        _amount = @([NULL_TO_NIL(dictionary[@"amount"]) intValue]);
    }
    return self;
}

- (instancetype)init
{
    return [self initWithJsonDictionary:nil error:nil];
}

@end
