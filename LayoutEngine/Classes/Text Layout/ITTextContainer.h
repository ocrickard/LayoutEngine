//
//  ITTextContainer.h
//  LayoutEngine
//
//  Copyright (c) 2013 Chaitanya Pandit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITTextLayoutProtocol.h"

@interface ITTextContainer : NSTextContainer
{
}

@property (weak) UITextView *textViewToUse;

@end
