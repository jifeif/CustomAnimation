
//
//  CustomAnimationTranstion.m
//  CustomAnimation
//
//  Created by 9188iMac on 16/9/7.
//  Copyright © 2016年 9188iMac. All rights reserved.
//

#import "CustomAnimationTranstion.h"



@interface CustomAnimationTranstion ()

@end


@implementation CustomAnimationTranstion
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    if (push == _type || pop == _type) {
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        [[transitionContext containerView] insertSubview:toVC.view belowSubview:fromVC.view];
        
        toVC.view.transform = CGAffineTransformMakeTranslation(320, 568);
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromVC.view.transform = CGAffineTransformMakeTranslation(-320, -568);
            toVC.view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }else if (present == _type){
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        [[transitionContext containerView] insertSubview:toVC.view aboveSubview:fromVC.view];
        UIView *view = transitionContext.containerView;
        UIBezierPath *beizpath = [UIBezierPath bezierPathWithRect:CGRectMake(view.center.x - 50, view.center.y - 30, 100, 60)];
        UIBezierPath *lastPath = [UIBezierPath bezierPathWithRect:toVC.view.bounds];
        CAShapeLayer *mask = [CAShapeLayer layer];
        mask.path = beizpath.CGPath;
        toVC.view.layer.mask = mask;
        
        CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"path"];
        ani.delegate = self;
        ani.fromValue = (__bridge id _Nullable)(beizpath.CGPath);
        ani.toValue = (__bridge id _Nullable)(lastPath.CGPath);
        ani.duration = [self transitionDuration:transitionContext];
        [ani setValue:transitionContext forKey:@"temp"];
        [mask addAnimation:ani forKey:@"mask"];
    }else if (dismiss == _type) {
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIView *containerView = transitionContext.containerView;
        [containerView insertSubview:toVC.view atIndex:0];
        CGFloat radius = sqrtf(pow([UIScreen mainScreen].bounds.size.width / 2, 2) + pow([UIScreen mainScreen].bounds.size.height / 2, 2));
        UIBezierPath *startPath = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle: 0 endAngle:M_PI * 2 clockwise:YES];
        UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(containerView.center.x - 50, containerView.center.y - 30, 100, 60)];
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = containerView.frame;
        maskLayer.path = startPath.CGPath;
        fromVC.view.layer.mask = maskLayer;
        
        CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"path"];
        basic.delegate = self;
        basic.fromValue = (__bridge id _Nullable)(startPath.CGPath);
        basic.toValue = (__bridge id _Nullable)(endPath.CGPath);
        basic.duration = [self transitionDuration:transitionContext];
        basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [basic setValue:transitionContext forKey:@"dismissBasic"];
        [maskLayer addAnimation:basic forKey:@"dismissBasicAnimation"];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (_type == dismiss) {
        id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"dismissBasic"];
        [transitionContext completeTransition:YES];
        [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    }else{
        id <UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"temp"];
        [transitionContext completeTransition:YES];
        [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
    }
}
@end
