//
//  UIViewController+MFFadeBackModalAnimation.m
//  MFFadeBackModalAnimation
//
//  Created by Michael Frederick on 4/10/13.
//  Copyright (c) 2013 Frederick Development. All rights reserved.
//

#import "UIViewController+MFFadeBackModalAnimation.h"
#import <QuartzCore/QuartzCore.h>

static const CGFloat animationDuration = 0.5f;

@implementation UIViewController (MFFadeBackModalAnimation)


#pragma mark -
#pragma mark - External API

- (void)presentViewControllerWithFadebackAnimation:(UIViewController *)controller completion:(void (^)(void))completion {
    [self presentViewController:controller animated:YES completion:nil];
    [controller.presentingViewController presentingViewControllerPerformFadeBackAnimationCompletion:completion];
}

- (void)dismissViewControllerWithFadebackAnimationCompletion:(void (^)(void))completion {
    UIViewController *presentingController = self;
    if(!self.presentedViewController && self.presentingViewController) {
        presentingController = self.presentingViewController;
    }
    
    [self dismissViewControllerAnimated:YES completion:completion];
    [presentingController presentingViewControllerPerformFadeInAnimationCompletion:nil];
}


#pragma mark -
#pragma mark - Internal API

// THIS IS CALLED ON THE PRESENTING VIEW CONTROLLER
- (void)presentingViewControllerPerformFadeBackAnimationCompletion:(void (^)(void))completion {
    [self setupFadeBackViewForAnimation];
    
    void (^animations)(void) = ^{
        [self performTiltBackEffect];
    };
    
    void (^innerCompletion)(BOOL) = ^(BOOL finished) {
        [self resetTransforms];
        if(completion) completion();
    };
    
    [UIView animateWithDuration:animationDuration animations:animations completion:innerCompletion];
}

// THIS IS CALLED ON THE PRESENTING VIEW CONTROLLER
- (void)presentingViewControllerPerformFadeInAnimationCompletion:(void (^)(void))completion {
    [self addSublayerTranform];
    [self performTiltBackEffect];
    
    void (^animations)(void) = ^{
        [self performReverseTiltEffect];
    };
    
    void (^innerCompletion)(BOOL) = ^(BOOL finished) {
        [self resetTransforms];
        if(completion) completion();
    };
    
    [UIView animateWithDuration:animationDuration animations:animations completion:innerCompletion];
}


#pragma mark -
#pragma mark - Transforms

- (void)addSublayerTranform {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0f / -300.0f;
    self.fadeBackView.superview.layer.sublayerTransform = transform;
}

- (void)resetTransforms {
    self.fadeBackView.layer.transform = CATransform3DIdentity;
    self.fadeBackView.superview.layer.sublayerTransform = CATransform3DIdentity;
}

- (void)performTiltBackEffect {
    self.fadeBackView.layer.opacity = 0.7f;
    self.fadeBackView.layer.transform = CATransform3DMakeRotation((10.0f * M_PI / 180.0f), 1.0f, 0.0f, 0.0f);
}

- (void)performReverseTiltEffect {
    self.fadeBackView.layer.opacity = 1.0f;
    self.fadeBackView.layer.transform = CATransform3DIdentity;
}


#pragma mark -
#pragma mark - Helpers

- (UIView *)fadeBackView {
    return self.view;
}

- (void)setupFadeBackViewForAnimation {
    [self setAnchorPoint:CGPointMake(0.5f, 1.0f) forView:self.fadeBackView];
    self.fadeBackView.layer.borderWidth = 1;
    self.fadeBackView.layer.borderColor = [UIColor clearColor].CGColor;
    self.fadeBackView.layer.shouldRasterize = YES;
    
    [self addSublayerTranform];
}

-(void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view {
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x, view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    position.x = position.x - oldPoint.x + newPoint.x;
    position.y = position.y - oldPoint.y + newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
}

@end
