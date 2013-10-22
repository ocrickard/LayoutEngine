//
//  ITViewController.m
//  LayoutEngine
//
//  Copyright (c) 2013 Chaitanya Pandit. All rights reserved.
//

#import "ITViewController.h"

@interface ITViewController ()

@end

@implementation ITViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *placeholder = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    placeholder = [placeholder stringByAppendingString:placeholder];
    
    NSTextStorage* textStorage = [[NSTextStorage alloc] initWithString:placeholder];

    CGFloat topOffset = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGRect textViewFrame = self.view.bounds;
    textViewFrame.origin.y += topOffset;
    textViewFrame.size.height -= topOffset;

    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    ITTextContainer *container = [[ITTextContainer alloc] initWithSize:textViewFrame.size];
    [layoutManager addTextContainer:container];
    layoutManager.allowsNonContiguousLayout = YES;
    self.textView = [[ITTextView alloc] initWithFrame:textViewFrame textContainer:container];
    [self.view addSubview:self.textView];
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.font = [UIFont systemFontOfSize:14.0f];
    container.textViewToUse = self.textView;
    container.widthTracksTextView = YES;
    container.heightTracksTextView = YES;
    
    ITTextAttachmentView *imageView = [[ITTextAttachmentView alloc] initWithFrame:CGRectMake(100.0f, 100.0f, 100.0f, 100.0f)];
    imageView.backgroundColor = [UIColor blueColor];
    [self.textView addSubview:imageView];
    imageView.alpha = 0.7f;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"txt.lay" object:self];
}

@end
