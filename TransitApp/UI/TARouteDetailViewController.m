//
//  TARouteDetailViewController.m
//  TransitApp
//
//  Created by Inam Abbas on 9/20/15.
//  Copyright © 2015 Inam Abbas. All rights reserved.
//

#import "TARouteDetailViewController.h"
#import "TASegment.h"
#import "TAStop.h"
#import "TARouteElement.h"
#import "TAStopCell.h"
#import "TATransportCell.h"
#import <MapKit/MapKit.h>
#import "MKPolyline+EncodedString.h"
#import "TARouteDetailViewController+TARouteElements.h"

static NSString* const TATransportCellId = @"TATransportCell";
static NSString* const TAStopCellId = @"TAStopCell";

/*
 The different mode to display route detail
 */
typedef NS_ENUM(NSUInteger, TARouteDisplayMode) {
    
    /*
     Display route data as list in tableview. This mode is the default mode.
     */
    TARouteDisplayModeList,
    
    /*
     Display routes on mapview
     */
    TARouteDisplayModeMap,
};


@interface TARouteDetailViewController() <MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic) NSDateFormatter *dateFormatter;
@property (nonatomic) TARouteDisplayMode displayMode;
@property (nonatomic) NSArray *routeElements;

@end

@implementation TARouteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.routeElements = [self configureRouteElements];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"HH:mm"];
    
    self.displayMode = TARouteDisplayModeList;
    
    [self configureRouteElements];
    
    [self setMapRegion];
    
    for (TASegment *segment in self.segments) {
        MKPolyline *polyline = [MKPolyline polylineWithEncodedString:segment.polyline];
        [self.mapView addOverlay:polyline];
    }
}

- (void)setMapRegion
{
    if (self.segments.count == 0)
        return;
    
    TASegment *firstSegment = self.segments[0];
    TAStop *firstStop = firstSegment.stops[0];
    
    CLLocationCoordinate2D firstStopCoordinates = CLLocationCoordinate2DMake([firstStop.latitude doubleValue], [firstStop.longitude doubleValue]);
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005); // street zoom
    self.mapView.region = MKCoordinateRegionMake(firstStopCoordinates, span);
}

- (NSString *)barButtonTitleForDisplayMode:(TARouteDisplayMode)mode
{
    if (mode == TARouteDisplayModeList)
        return NSLocalizedString(@"Map", @"button title");

    return NSLocalizedString(@"List", @"button title");
}

- (void)setDisplayMode:(TARouteDisplayMode)displayMode
{
    if (_displayMode == displayMode)
        return;
    
    _displayMode = displayMode;
    self.tableView.hidden = displayMode != TARouteDisplayModeList;
    self.mapView.hidden = displayMode != TARouteDisplayModeMap;
}

- (IBAction)rightBarButtonPressed:(id)sender
{
    UIBarButtonItem *button = sender;
    self.displayMode = (self.displayMode == TARouteDisplayModeList) ? TARouteDisplayModeMap : TARouteDisplayModeList;
    button.title = [self barButtonTitleForDisplayMode:self.displayMode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.routeElements.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TARouteElement *routeElement = self.routeElements[indexPath.row];

    switch (routeElement.type) {
        case TARouteElementTypeStop:
            return [self stopCellForRowAtIndexPath:indexPath];
            
        case TARouteElementTypeTransport:
            return [self transportCellForRowAtIndexPath:indexPath];
        
        default:
            return nil;
    }
}

- (UITableViewCell *)transportCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TATransportCell *cell = (TATransportCell *)[self.tableView dequeueReusableCellWithIdentifier:TATransportCellId forIndexPath:indexPath];
    
    TARouteElement *routeElement = self.routeElements[indexPath.row];
    
    cell.titleLabel.text = routeElement.title;
    cell.titleLabel.hidden = routeElement.title.length == 0;
    
    cell.durationLabel.text = [NSString stringWithFormat:@"%d min", (int)(routeElement.duration / 60)];
    cell.detailLabel.text = routeElement.detailText;
    
    return cell;
}

- (UITableViewCell *)stopCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TAStopCell *cell = (TAStopCell *)[self.tableView dequeueReusableCellWithIdentifier:TAStopCellId forIndexPath:indexPath];
    
    TARouteElement *routeElement = self.routeElements[indexPath.row];
    cell.timeLabel.text = [self.dateFormatter stringFromDate:routeElement.time];
    cell.detailLabel.text = routeElement.detailText;
    return cell;
}

#pragma mark - Map View delegate methods

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    MKPolylineView *polylineView = [[MKPolylineView alloc] initWithPolyline:overlay];
    polylineView.strokeColor = [self randomColor];
    polylineView.lineWidth = 10.0;
    
    return polylineView;
}

-(UIColor *)randomColor
{
    NSInteger aRedValue = arc4random()%255;
    NSInteger aGreenValue = arc4random()%255;
    NSInteger aBlueValue = arc4random()%255;
    
    UIColor *randColor = [UIColor colorWithRed:aRedValue/255.0f green:aGreenValue/255.0f blue:aBlueValue/255.0f alpha:1.0f];
    return randColor;
}

@end
