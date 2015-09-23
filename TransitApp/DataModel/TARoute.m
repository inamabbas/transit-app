//
//  TARoute.m
//  TransitApp
//
//  Created by Inam Abbas on 9/16/15.
//  Copyright (c) 2015 Inam Abbas. All rights reserved.
//

#import "TARoute.h"
#import "TASegment.h"
#import "TAStop.h"
#import "TAPrice.h"
#import "TAParsingUtil.h"


@implementation TARoute

- (instancetype)initWithJsonDictionary:(NSDictionary *)dictionary error:(NSError **)error
{
    self = [super init];
    if (self) {
        _type = NULL_TO_NIL(dictionary[@"type"]);
        _provider = NULL_TO_NIL(dictionary[@"provider"]);
        NSDictionary *price = NULL_TO_NIL(dictionary[@"price"]);
        if (price)
            _price = [[TAPrice alloc] initWithJsonDictionary:price error:nil];
        
        
        NSError *segmentError = nil;
        NSMutableArray *segments = [[NSMutableArray alloc] init];
        for (NSDictionary *segmentObj in dictionary[@"segments"]) {
            TASegment *segment = [[TASegment alloc] initWithJsonDictionary:segmentObj error:&segmentError];
            if (segmentError)
                break;
            
            [segments addObject:segment];
        }
        
        _segments = segments;
        
        if (segmentError)
        {
            if (error)
                *error = segmentError;
        } else {
            if (_segments.count > 0) {
                TASegment *startSegment = _segments[0];
                TASegment *endSegment = _segments[_segments.count-1];
                
                TAStop *startStop = startSegment.stops[0];
                TAStop *endStop = endSegment.stops[endSegment.stops.count-1];
                
                _startTime = startStop.dateTime;
                _endTime = endStop.dateTime;
                
            }
        }
    }
    
    return self;
}

- (instancetype)init
{
    return [self initWithJsonDictionary:nil error:nil];
}

@end
