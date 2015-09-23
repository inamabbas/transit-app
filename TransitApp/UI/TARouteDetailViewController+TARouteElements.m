//
//  TARouteDetailViewController+TARouteElements.m
//  TransitApp
//
//  Created by Inam Abbas on 9/22/15.
//  Copyright © 2015 Inam Abbas. All rights reserved.
//

#import "TARouteDetailViewController+TARouteElements.h"
#import "TASegment.h"
#import "TAStop.h"
#import "TARouteElement.h"
#import "TATransportView.h"

@implementation TARouteDetailViewController (TARouteElements)

- (NSArray *)configureRouteElements
{
    NSMutableArray *routeElements = [NSMutableArray array];
    
    [routeElements addObject:[self currentLocationRouteElement]];
    
    for (int i = 0; i < self.segments.count; i++) {
        [routeElements addObjectsFromArray:[self routeElementsForSegmentAtIndex:i]];
    }
    
    return routeElements;
}

- (TARouteElement *)currentLocationRouteElement
{
    TASegment *segment = self.segments[0];
    
    TARouteElement *routeElement = [[TARouteElement alloc] init];
    routeElement.type = TARouteElementTypeStop;
    routeElement.time = segment.startTime;
    routeElement.detailText = NSLocalizedString(@"Your location", @"current location label");
    
    return routeElement;
}

- (NSArray *)routeElementsForSegmentAtIndex:(NSInteger)index
{
    TASegment *segment = self.segments[index];
    
    switch (segment.travelMode) {
        case TATravelModeWalking:
            return [self routeElementsForWalkingSegmentAtIndex:index];
            
        case TATravelModeSubway:
            return [self routeElementsForSubwaySegmentAtIndex:index];
            
        case TATravelModeBus:
            return [self routeElementsForBusSegmentAtIndex:index];
            
        case TATravelModeChange:
            return [self routeElementsForChangeSegmentAtIndex:index];
            
        case TATravelModeSetup:
            return [self routeElementsForSetupSegmentAtIndex:index];
            
        case TATravelModeDriving:
            return [self routeElementsForDrivingSegmentAtIndex:index];
            
        case TATravelModeParking:
            return [self routeElementsForParkingSegmentAtIndex:index];
            
        case TATravelModeCycling:
            return [self routeElementsForCyclingSegmentAtIndex:index];
    }
}

- (NSArray *)routeElementsForWalkingSegmentAtIndex:(NSInteger)index
{
    TASegment *segment = self.segments[index];
    
    TARouteElement *transportElement = [self routeTransportElementWithDetail:NSLocalizedString(@"Walk", @"Walking label") duration:[self durationForSegment:segment] title:nil];
    
    return @[transportElement, [self lastStopElementForSegment:segment]];
}

- (NSArray *)routeElementsForSubwaySegmentAtIndex:(NSInteger)index
{
    TASegment *segment = self.segments[index];
    TARouteElement *transportElement = [self routeTransportElementWithDetail:segment.segmentDescription duration:[self durationForSegment:segment] title:segment.name];

    return @[transportElement, [self lastStopElementForSegment:segment]];
}

- (NSArray *)routeElementsForBusSegmentAtIndex:(NSInteger)index
{
    TASegment *segment = self.segments[index];
    TARouteElement *transportElement = [self routeTransportElementWithDetail:segment.segmentDescription duration:[self durationForSegment:segment] title:segment.name];

    return @[transportElement, [self lastStopElementForSegment:segment]];
}

- (NSArray *)routeElementsForChangeSegmentAtIndex:(NSInteger)index
{
    TASegment *segment = self.segments[index];
    TASegment *nextSegment;
    NSInteger nextSegmentIndex = index + 1;
    if (self.segments.count > nextSegmentIndex)
        nextSegment = self.segments[nextSegmentIndex];
    
    NSString *detail = [NSString stringWithFormat:NSLocalizedString(@"Change to %@", @"change transport label"), nextSegment.name];
    TARouteElement *transportElement = [self routeTransportElementWithDetail:detail duration:[self durationForSegment:segment] title:nil];

    return @[transportElement, [self lastStopElementForSegment:segment]];
}

- (NSArray *)routeElementsForSetupSegmentAtIndex:(NSInteger)index
{
    TASegment *segment = self.segments[index];
    TARouteElement *transportElement = [self routeTransportElementWithDetail:NSLocalizedString(@"Setup", @"setup time") duration:[self durationForSegment:segment] title:nil];
    
    return @[transportElement];
}

- (NSArray *)routeElementsForDrivingSegmentAtIndex:(NSInteger)index
{
    TASegment *segment = self.segments[index];
    
    TARouteElement *transportElement = [self routeTransportElementWithDetail:NSLocalizedString(@"Drive", @"Drive label") duration:[self durationForSegment:segment] title:nil];

    return @[transportElement, [self lastStopElementForSegment:segment]];
}

- (NSArray *)routeElementsForParkingSegmentAtIndex:(NSInteger)index
{
    TASegment *segment = self.segments[index];

    TARouteElement *transportElement = [self routeTransportElementWithDetail:NSLocalizedString(@"Parking", @"Parking label") duration:[self durationForSegment:segment] title:nil];

    return @[transportElement, [self lastStopElementForSegment:segment]];
}

- (NSArray *)routeElementsForCyclingSegmentAtIndex:(NSInteger)index
{
    TASegment *segment = self.segments[index];
    
    TARouteElement *transportElement = [self routeTransportElementWithDetail:NSLocalizedString(@"Cycling", @"cycling label") duration:[self durationForSegment:segment] title:nil];

    return @[transportElement, [self lastStopElementForSegment:segment]];
}

- (NSString *)durationForSegment:(TASegment *)segment
{
    return [NSString stringWithFormat:@"%f", [segment.endTime timeIntervalSinceDate:segment.startTime]];
}

- (TARouteElement *)lastStopElementForSegment:(TASegment *)segment
{
    TAStop *lastStop = [segment.stops lastObject];
    TARouteElement *stopElement = [self routeStopElementWithDetail:lastStop.name dateTime:lastStop.dateTime];
    return stopElement;
}

- (TARouteElement *)routeStopElementWithDetail:(NSString *)detail dateTime:(NSDate *)dateTime
{
    TARouteElement *transportElement = [[TARouteElement alloc] init];
    transportElement.type = TARouteElementTypeStop;
    transportElement.time = dateTime;
    transportElement.detailText = detail;
    
    return transportElement;
}

- (TARouteElement *)routeTransportElementWithDetail:(NSString *)detail duration:(NSString *)duration title:(NSString *)title
{
    TARouteElement *transportElement = [[TARouteElement alloc] init];
    transportElement.type = TARouteElementTypeTransport;
    transportElement.duration = [duration integerValue];
    transportElement.title = title;
    transportElement.detailText = detail;
    
    return transportElement;
}


@end
