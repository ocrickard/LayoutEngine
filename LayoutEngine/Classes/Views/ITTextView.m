//
//  ITTextView.m
//  LayoutEngine
//
//  Copyright (c) 2013 Chaitanya Pandit. All rights reserved.
//

#import "ITTextView.h"

@implementation ITTextView

- (void)initialize
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layoutChanged:) name:@"txt.lay" object:nil];
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

- (id)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer
{
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {

        [self initialize];
    }

    return self;
}

- (void)layoutChanged:(NSNotification *)aNotification
{
    [self.layoutManager textContainerChangedGeometry:self.textContainer];
    [self.layoutManager ensureLayoutForTextContainer:self.textContainer];
}

@end
