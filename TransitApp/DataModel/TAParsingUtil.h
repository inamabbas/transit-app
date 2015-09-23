//
//  TAParsingUtil.h
//  TransitApp
//
//  Created by Inam Abbas on 9/22/15.
//  Copyright © 2015 Inam Abbas. All rights reserved.
//

#define NULL_TO_NIL(obj) ({ __typeof__ (obj) __obj = (obj); __obj == [NSNull null] ? nil : obj; })
