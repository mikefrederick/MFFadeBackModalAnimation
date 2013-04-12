//
//  MFModalViewController.m
//  MFFadeBackModalAnimation
//
//  Created by Michael Frederick on 4/10/13.
//  Copyright (c) 2013 Frederick Development. All rights reserved.
//

#import "MFModalViewController.h"
#import "UIViewController+MFFadeBackModalAnimation.h"

@interface MFModalViewController ()

@end

@implementation MFModalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor redColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                              target:self action:@selector(dismiss)];
}

- (void)dismiss {
    [self dismissViewControllerWithFadebackAnimationCompletion:nil];
}

@end
