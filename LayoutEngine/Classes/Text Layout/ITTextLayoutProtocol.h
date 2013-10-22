//
//  ITTextLayoutProtocol.h
//  LayoutEngine
//
//  Copyright (c) 2013 Chaitanya Pandit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TextLayoutPlacementProtocol <NSObject>

- (BOOL)causesWrap;
- (CGRect)exclusionRect;

@end

