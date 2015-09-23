//
//  TASegment.m
//  TransitApp
//
//  Created by Inam Abbas on 9/16/15.
//  Copyright (c) 2015 Inam Abbas. All rights reserved.
//

#import "TASegment.h"
#import "TAStop.h"
#import "TAParsingUtil.h"

@implementation TASegment

- (instancetype)initWithJsonDictionary:(NSDictionary *)dictionary error:(NSError **)error
{
    self = [super init];
    if (self) {
        _name = NULL_TO_NIL(dictionary[@"name"]);
        _stopsCount = @([NULL_TO_NIL(dictionary[@"num_stops"]) intValue]);
        _travelMode = [self travelModeWithString:NULL_TO_NIL(dictionary[@"travel_mode"])];
        _segmentDescription = NULL_TO_NIL(dictionary[@"description"]);
        _color = NULL_TO_NIL(dictionary[@"color"]);
        _iconURL = NULL_TO_NIL(dictionary[@"icon_url"]);
        _polyline = NULL_TO_NIL(dictionary[@"polyline"]);
        
        NSError *stopError = nil;
        NSMutableArray *stops = [[NSMutableArray alloc] init];
        for (NSDictionary *stopObj in dictionary[@"stops"]) {
            TAStop *stop = [[TAStop alloc] initWithJsonDictionary:stopObj error:&stopError];
            if (stopError)
                break;
            
            [stops addObject:stop];
        }
        _stops = stops;
        
        if (stopError)
        {
            if (error)
                *error = stopError;
        }
        else
        {
            if (_stops.count > 0) {
                TAStop *startStop = _stops[0];
                TAStop *endStop = _stops[_stops.count-1];
                
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

- (TATravelMode)travelModeWithString:(NSString *)mode
{
    if ([mode isEqualToString:@"walking"])
        return TATravelModeWalking;
    
    if ([mode isEqualToString:@"subway"])
        return TATravelModeSubway;
    
    if ([mode isEqualToString:@"bus"])
        return TATravelModeBus;
    
    if ([mode isEqualToString:@"change"])
        return TATravelModeChange;
    
    if ([mode isEqualToString:@"setup"])
        return TATravelModeSetup;
    
    if ([mode isEqualToString:@"driving"])
        return TATravelModeDriving;
    
    if ([mode isEqualToString:@"parking"])
        return TATravelModeParking;
    
    if ([mode isEqualToString:@"cycling"])
        return TATravelModeCycling;
    
    return TATravelModeWalking;
}

@end
