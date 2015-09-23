//
//  TAStop.m
//  TransitApp
//
//  Created by Inam Abbas on 9/16/15.
//  Copyright (c) 2015 Inam Abbas. All rights reserved.
//

#import "TAStop.h"
#import "TAParsingUtil.h"

@implementation TAStop

- (instancetype)initWithJsonDictionary:(NSDictionary *)dictionary error:(NSError **)error
{
    self = [super init];
    if (self) {
        _name = NULL_TO_NIL(dictionary[@"name"]);        
        _longitude = @([NULL_TO_NIL(dictionary[@"lng"]) doubleValue]);
        _latitude = @([NULL_TO_NIL(dictionary[@"lat"]) doubleValue]);
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZ"];
        
        NSString *dateTime = NULL_TO_NIL(dictionary[@"datetime"]);
        if (dateTime)
            _dateTime = [dateFormatter dateFromString:dateTime];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithJsonDictionary:nil error:nil];
}

@end
