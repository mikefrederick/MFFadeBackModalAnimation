//
//  MFViewController.m
//  MFFadeBackModalAnimation
//
//  Created by Michael Frederick on 4/10/13.
//  Copyright (c) 2013 Frederick Development. All rights reserved.
//

#import "MFViewController.h"
#import "MFModalViewController.h"
#import "UIViewController+MFFadeBackModalAnimation.h"

@interface MFViewController ()
@end

@implementation MFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Check out my title";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPressed:)];
}

- (void)addPressed:(id)sender {
    MFModalViewController *modalViewController = [[MFModalViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:modalViewController];
    [self presentViewControllerWithFadebackAnimation:navigationController completion:nil];
}

@end
