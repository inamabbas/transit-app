//
//  TARoutesListViewController.m
//  TransitApp
//
//  Created by Inam Abbas on 9/16/15.
//  Copyright (c) 2015 Inam Abbas. All rights reserved.
//

#import "TARoutesListViewController.h"
#import "TARoutesParser.h"
#import "TARoutesData.h"
#import "TARoute.h"
#import "TASegment.h"
#import "TAProvider.h"
#import "TAPrice.h"
#import "TARouteCell.h"
#import "TATransportView.h"
#import <Haneke/Haneke.h>
#import "UIColor+HexaString.h"
#import "TARouteDetailViewController.h"


static NSString* const TARouteCellId = @"TARouteCell";

@interface TARoutesListViewController ()

@property (nonatomic) NSDictionary *providers;
@property (nonatomic) NSArray *routes;
@property (nonatomic) NSDateFormatter* dateFormatter;

- (void)loadRoutesAsync;

@end

@implementation TARoutesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"HH:mm"];
    
    //Load routes from json file asynchronously
    [self loadRoutesAsync];
}

- (void)loadRoutesAsync {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSError *error = nil;
        TARoutesData *routesData = [self loadRoutesWithError:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (routesData)
                [self didLoadRoutesData:routesData];
            else
                [self didFailLoadingRoutesWithError:error];
        });
    });
}

- (TARoutesData *)loadRoutesWithError:(NSError **)error
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return [[TARoutesParser sharedInstance] parseRoutesData:data error:error];
}

- (void)didLoadRoutesData:(TARoutesData *)routesData
{
    self.providers = routesData.providers;
    self.routes = routesData.routes;
    [self.tableView reloadData];
}

- (void)didFailLoadingRoutesWithError:(NSError *)error
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:NSLocalizedString(@"Alert", @"alert title")
                                  message:error.localizedDescription
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:NSLocalizedString(@"Cancel", @"cancel title")
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
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
    return self.routes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TARouteCell *cell = (TARouteCell *)[tableView dequeueReusableCellWithIdentifier:TARouteCellId forIndexPath:indexPath];
    
    TARoute *route = self.routes[indexPath.row];
    
    cell.transportTypeLabel.text = [self transportTitleForType:route.type];
    
    cell.priceLabel.text = [NSString stringWithFormat:@"%@%.02f", route.price.currency, [route.price.amount doubleValue] / 100];
    cell.priceLabel.hidden = route.price.amount == nil;
    
    cell.durationLabel.text = [NSString stringWithFormat:@"%d min", (int)round([route.endTime timeIntervalSinceDate:route.startTime] / 60)];
    
    cell.travelingTimeLabel.text = [NSString stringWithFormat:@"%@ - %@", [self.dateFormatter stringFromDate:route.startTime], [self.dateFormatter stringFromDate:route.endTime]];
    
    for (TASegment *segment in route.segments) {
        TATransportView *transportView = [[NSBundle mainBundle] loadNibNamed:@"TATransportView" owner:cell options:nil].firstObject;
        [self setupTransportView:transportView withSegment:segment];
        [cell.segmentsView addArrangedSubview:transportView];
    }

    return cell;
}

- (void)setupTransportView:(TATransportView *)transportView withSegment:(TASegment *)segment
{
    UIColor *color = [UIColor colorWithHexString:segment.color];
    [transportView.layer setBorderColor:color.CGColor];
    
    __weak UIImageView *weakImageView = transportView.transportImageView;
    weakImageView.image = nil;
    [weakImageView hnk_setImageFromURL:[NSURL URLWithString:segment.iconURL]
                           placeholder:[UIImage imageNamed:@"placeholder.png"]
                               success:^(UIImage *image) {
                                   UIImage *templateImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                                   weakImageView.image = templateImage;
                               }
                               failure:nil];
    
    transportView.transportLabel.text = segment.name;
    transportView.backgroundColor = color;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TARoute *route = self.routes[indexPath.row];
    [self performSegueWithIdentifier:@"RouteListView-RouteDetailView" sender:route.segments];
}

- (NSString *)transportTitleForType:(NSString *)type
{
    if ([type isEqualToString:@"taxi"])
        return NSLocalizedString(@"Taxi", @"taxi label");
    
    if ([type isEqualToString:@"public_transport"])
        return NSLocalizedString(@"Public Transport", @"public transport label");
    
    if ([type isEqualToString:@"car_sharing"])
        return NSLocalizedString(@"Car Sharing", @"car sharing label");
    
    if ([type isEqualToString:@"private_bike"])
        return NSLocalizedString(@"Private Bike", @"private bike label");
    
    if ([type isEqualToString:@"bike_sharing"])
        return NSLocalizedString(@"Bike Sharing", @"bike sharing label");
    
    return nil;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"RouteListView-RouteDetailView"]) {
        TARouteDetailViewController *routeDetailViewController = [segue destinationViewController];
        routeDetailViewController.segments = sender;
    }
}


@end
