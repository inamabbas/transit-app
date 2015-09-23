//
//  TATransportView.m
//  TransitApp
//
//  Created by Inam Abbas on 9/21/15.
//  Copyright © 2015 Inam Abbas. All rights reserved.
//

#import "TATransportView.h"
#import <Haneke/Haneke.h>

@implementation TATransportView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[self(==56)]"] options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[self(==93)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
        
        [self.layer setCornerRadius:6];
        [self.layer setMasksToBounds:YES];
        [self.layer setBorderWidth:1];
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return self;
}

@end
