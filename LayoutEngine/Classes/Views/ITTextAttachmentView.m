//
//  ITTextAttachmentView.m
//  LayoutEngine
//
//  Copyright (c) 2013 Chaitanya Pandit. All rights reserved.
//

#import "ITTextAttachmentView.h"

@implementation ITTextAttachmentView

#pragma mark initialization

- (void)initialize
{
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self addGestureRecognizer:self.panGestureRecognizer];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {

        [self initialize];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self initialize];
    }

    return self;
}

#pragma mark Actions

- (void)panAction:(UIPanGestureRecognizer *)sender
{
    CGPoint translatedPoint = [sender translationInView:self];

    if (sender.state == UIGestureRecognizerStateBegan)
    {
        mInitialPointBeforePan = [[sender view] center];
    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        translatedPoint = CGPointMake(mInitialPointBeforePan.x+translatedPoint.x, mInitialPointBeforePan.y+translatedPoint.y);
        [self setCenter:translatedPoint];

        [[NSNotificationCenter defaultCenter] postNotificationName:@"txt.lay" object:self];
    }
}

#pragma mark TextLayoutPlacementProtocol

- (BOOL)causesWrap
{
    return YES;
}

- (CGRect)exclusionRect
{
	return self.frame;
}

@end