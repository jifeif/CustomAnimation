//
//  FirstViewController.m
//  CustomAnimation
//
//  Created by 9188iMac on 16/9/7.
//  Copyright © 2016年 9188iMac. All rights reserved.
//

#import "FirstViewController.h"
#import "CustomAnimationTranstion.h"
#import "SecondViewController.h"
@interface FirstViewController ()<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *pushBtn;
@property (nonatomic, strong) CAShapeLayer *loadingLayer;

@end

@implementation FirstViewController

- (CAShapeLayer *)loadingLayer{
    if (!_loadingLayer) {
        _loadingLayer = [CAShapeLayer layer];
        _loadingLayer.bounds = CGRectMake(0, 0, 60, 60);
        _loadingLayer.position = self.view.center;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(30, 30) radius:30 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        _loadingLayer.lineWidth = 3;
        _loadingLayer.fillColor = [UIColor clearColor].CGColor;
        _loadingLayer.strokeColor = [UIColor blackColor].CGColor;
        _loadingLayer.path = path.CGPath;
    }
    return _loadingLayer;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.pushBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.pushBtn.layer.borderWidth = 2;
    self.pushBtn.layer.cornerRadius = 15;
    self.pushBtn.layer.masksToBounds = YES;
}


- (IBAction)pushMethod:(id)sender {
    [self rotationAnimation];
}

- (void)rotationAnimation{
    [self.view.layer addSublayer:self.loadingLayer];
    self.pushBtn.hidden = YES;
    //园旋转。 通过笔画开始动画，和笔画结束动画。
    CABasicAnimation *start = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    start.fromValue =  @(-0.5);
    start.toValue = @(1);
    
    CABasicAnimation *end = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    end.fromValue = @(0);
    end.toValue = @(1);
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.delegate = self;
    group.animations = @[start, end];
    group.duration = 0.5;
    group.repeatDuration = 1;
    [self.loadingLayer addAnimation:group forKey:@"group"];
}


- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    CustomAnimationTranstion *cu = [[CustomAnimationTranstion alloc] init];
    cu.type = push;
    return cu;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.loadingLayer removeFromSuperlayer];
    self.pushBtn.hidden = NO;
    SecondViewController *sec = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Second"];
    [self presentViewController:sec animated:YES completion:^{}];

}


@end
