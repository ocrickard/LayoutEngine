//
//  ITTextContainer.m
//  LayoutEngine
//
//  Copyright (c) 2013 Chaitanya Pandit. All rights reserved.
//

#import "ITTextContainer.h"

@implementation ITTextContainer

NSInteger  compareViewsByFrame(id view1, id view2, void *context)
{
	NSInteger retVal = NSOrderedSame;

    if ([view1 respondsToSelector:@selector(causesWrap)] && [view1 respondsToSelector:@selector(causesWrap)])
    {
        if ([view1 frame].origin.x < [view2 frame].origin.x)
            retVal = NSOrderedAscending;
        else
            retVal = NSOrderedDescending;
    }
    else
    {
        if ([view1 respondsToSelector:@selector(causesWrap)])
            retVal = NSOrderedAscending;
        else
            retVal = NSOrderedDescending;
    }

	return retVal;
}

- (CGRect)exclusionRectByApplyingPaddingForView:(id)view
{
    CGRect subViewRect = [(id)view exclusionRect];
    subViewRect.origin.y -= 10.0f;
    
    return subViewRect;
}

- (NSArray *)orderedAttachmentViews
{
    NSMutableArray *attachmentViews = [NSMutableArray arrayWithCapacity:self.textViewToUse.subviews.count-1]; // -1 for textcontainer view
    [self.textViewToUse.subviews enumerateObjectsUsingBlock:^(id view, NSUInteger idx, BOOL *stop) {
        if ([view respondsToSelector:@selector(causesWrap)])
        {
            [attachmentViews addObject:view];
        }
    }];

    return [attachmentViews sortedArrayUsingFunction:(NSInteger (*)(__strong id, __strong id, void *))compareViewsByFrame context:nil];
}

- (UIView *)getLeftmostView:(CGRect)actualRect ignoringViews:(NSArray *)viewsToIgnore
{
	UIView  __block *viewToReturn = nil;
    NSArray *subviews = [self orderedAttachmentViews];
    [subviews enumerateObjectsUsingBlock:^(UIView *currentView, NSUInteger idx, BOOL *stop) {

        if (![viewsToIgnore containsObject:currentView])
		{
			CGRect subViewRect = [self exclusionRectByApplyingPaddingForView:currentView];

			CGRect clashingRect = CGRectIntersection(subViewRect,actualRect);

			if (!CGRectIsEmpty(clashingRect) )
			{
                viewToReturn = currentView;
                *stop = YES;
			}
		}
	}];

	return viewToReturn;
}

- (BOOL)isRectToReturnAccepable:(CGRect)rectToReturn
{
    BOOL valid = YES;

    if (CGRectIsEmpty(rectToReturn) || rectToReturn.size.width < 20.0f)
        valid = NO;

    return valid;
}

- (CGRect)lineFragmentRectForProposedRect:(CGRect)proposedRect atIndex:(NSUInteger)characterIndex writingDirection:(NSWritingDirection)baseWritingDirection remainingRect:(CGRect *)remainingRect
{
	CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    CGRect actualProposedRect = CGRectIntersection(proposedRect, bounds);
    
	CGRect rectToReturn = CGRectZero;
	CGRect rectRemained = CGRectZero;
	CGRect clashingRect = CGRectZero;	

    NSMutableArray *viewsToSkip = [[NSMutableArray alloc] init];
    
    while (![self isRectToReturnAccepable:rectToReturn])
    {
        if (![self isRectToReturnAccepable:actualProposedRect])
        {
            actualProposedRect.size = CGSizeMake(self.size.width, proposedRect.size.height);
            actualProposedRect.origin = CGPointMake(0.0f, actualProposedRect.origin.y+actualProposedRect.size.height);
            [viewsToSkip removeAllObjects];
        }
        
        UIView *intersectingView = [self getLeftmostView:actualProposedRect ignoringViews:viewsToSkip];
        if (intersectingView)
        {
            [viewsToSkip addObject:intersectingView];

            CGRect intersectingRect = CGRectIntersection(actualProposedRect, [self exclusionRectByApplyingPaddingForView:intersectingView]);

            if (!CGRectIsEmpty(intersectingRect))
            {
                clashingRect = intersectingRect;
            }

            if (intersectingView && !CGRectIsEmpty(clashingRect))
            {
                rectToReturn = CGRectMake(actualProposedRect.origin.x, actualProposedRect.origin.y, clashingRect.origin.x - actualProposedRect.origin.x , actualProposedRect.size.height);
                rectRemained = CGRectMake(CGRectGetMaxX(clashingRect), actualProposedRect.origin.y, actualProposedRect.size.width-(CGRectGetMaxX(clashingRect) - actualProposedRect.origin.x), actualProposedRect.size.height);
                actualProposedRect = rectRemained;
            }
        }
        else
        {
            rectToReturn = actualProposedRect;
            actualProposedRect = rectRemained;
        }
    }

    (* remainingRect) = rectRemained;
    
	return rectToReturn;
}

@end
