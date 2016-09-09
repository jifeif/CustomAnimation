//
//  CustomAnimationTranstion.h
//  CustomAnimation
//
//  Created by 9188iMac on 16/9/7.
//  Copyright © 2016年 9188iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CustomAnimationTranstionType) {
    none,
    push,
    pop,
    present,
    dismiss
};


@interface CustomAnimationTranstion : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) CustomAnimationTranstionType type;
@end
