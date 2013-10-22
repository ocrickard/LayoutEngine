//
//  ITTextAttachmentView.h
//  LayoutEngine
//
//  Copyright (c) 2013 Chaitanya Pandit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITTextLayoutProtocol.h"

@interface ITTextAttachmentView : UIView <TextLayoutPlacementProtocol>
{
    CGPoint mInitialPointBeforePan;
    
}

@property UIPanGestureRecognizer *panGestureRecognizer;
@property (readonly) BOOL causesWrap;

@end
