//
//  SecondViewController.m
//  CustomAnimation
//  被作为蒙版的layer， view， 在初始化时，不需要设置位置，只需要设置大小。 默认以被遮遭的layer的坐标原点为坐标原点。
//  Created by 9188iMac on 16/9/7.
//  Copyright © 2016年 9188iMac. All rights reserved.
//

#import "SecondViewController.h"
#import "FirstViewController.h"
#import "CustomAnimationTranstion.h"

@interface SecondViewController ()<UIViewControllerTransitioningDelegate>
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) UILabel *aLabel;

@property (nonatomic, assign) CGFloat SCREEN_WIDTH;
@property (nonatomic, assign) CGFloat SCREEN_HEGHT;
@end

@implementation SecondViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (CAGradientLayer *)gradientLayer{
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.colors = @[(__bridge id __nullable)([UIColor redColor].CGColor),
                                  (__bridge id __nullable)([UIColor greenColor].CGColor),
                                  (__bridge id __nullable)([UIColor blueColor].CGColor)];
        _gradientLayer.frame = CGRectMake((_SCREEN_WIDTH - 240) / 2, 80, 240, 50);
        _gradientLayer.locations = @[@0.3, @0.6, @0.9];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(1, 0);
    }
    return _gradientLayer;
}

- (void)getALabel{
        self.aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 240, 50)];
        _aLabel.text = @"HELLO KITTY";
        _aLabel.textAlignment = NSTextAlignmentCenter;
        _aLabel.font = [UIFont boldSystemFontOfSize:20];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.SCREEN_HEGHT = [UIScreen mainScreen].bounds.size.height;
    self.SCREEN_WIDTH = [UIScreen mainScreen].bounds.size.width;
    [self.view.layer addSublayer:self.gradientLayer];
    [self getALabel];
    self.gradientLayer.mask = self.aLabel.layer;
    self.transitioningDelegate = self;
//    [self.view.layer addSublayer:self.gradientLayer];
//    self.gradientLayer.mask = self.aLabel.layer;
}

- (IBAction)popMethod:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:^{}];
    CABasicAnimation *basi = [CABasicAnimation animationWithKeyPath:@"bounds"];
    basi.duration = 4;
    basi.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 240, 3)];
    basi.repeatCount = 2;
    [self.gradientLayer addAnimation:basi forKey:@"basi"];
    
    
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    CustomAnimationTranstion *cu = [[CustomAnimationTranstion alloc] init];
    cu.type = pop;
    return cu;
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    CustomAnimationTranstion *cu = [[CustomAnimationTranstion alloc] init];
    cu.type = present;
    return cu;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    CustomAnimationTranstion *cu = [[CustomAnimationTranstion alloc] init];
    cu.type = dismiss;
    return cu;
}
@end
