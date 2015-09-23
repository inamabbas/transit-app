//
//  TARouteCell.m
//  TransitApp
//
//  Created by Inam Abbas on 9/16/15.
//  Copyright (c) 2015 Inam Abbas. All rights reserved.
//

#import "TARouteCell.h"

@implementation TARouteCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)prepareForReuse {
    for (UIView *subView in self.segmentsView.subviews) {
        [subView removeFromSuperview];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
