//
//  UIViewController+MFFadeBackModalAnimation.h
//  MFFadeBackModalAnimation
//
//  Created by Michael Frederick on 4/10/13.
//  Copyright (c) 2013 Frederick Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MFFadeBackModalAnimation)

- (void)presentViewControllerWithFadebackAnimation:(UIViewController *)controller completion:(void (^)(void))completion;
- (void)dismissViewControllerWithFadebackAnimationCompletion:(void (^)(void))completion;

@end
