//
//  TARouteCell.h
//  TransitApp
//
//  Created by Inam Abbas on 9/16/15.
//  Copyright (c) 2015 Inam Abbas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TARouteCell : UITableViewCell

@property (nonatomic) IBOutlet UIStackView *segmentsView;
@property (nonatomic) IBOutlet UILabel *transportTypeLabel;
@property (nonatomic) IBOutlet UILabel *priceLabel;
@property (nonatomic) IBOutlet UILabel *durationLabel;
@property (nonatomic) IBOutlet UILabel *travelingTimeLabel;

@end