//
//  HXPopView.m
//  ExampleDemo
//
//  Created by 刘军 on 2017/3/23.
//  Copyright © 2017年 hxzq. All rights reserved.
//

#define KEY_WINDOW [[UIApplication sharedApplication] keyWindow]
#define KEY_ANIMATION @"key_animation"
#define KEY_REVERSEANIMATION @"key_reverseAnimation"

#import "HXPopView.h"

@interface HXPopView () <CAAnimationDelegate>

@property (nonatomic, strong) UIView *backgroudView;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation HXPopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI {
    self.canTapDismiss = YES;
    self.backgroudView = [[UIView alloc] initWithFrame:self.bounds];
    self.backgroudView.backgroundColor = [UIColor blackColor];
    self.backgroudView.alpha = 0.5;
    [self addSubview:self.backgroudView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTapGestureRecognizer:)];
    [self.backgroudView addGestureRecognizer:tapGestureRecognizer];
}

- (void)clickTapGestureRecognizer:(UITapGestureRecognizer *)tapGestureRecognizer {
   
    if (self.canTapDismiss) {
        [self dismiss];
        if (self.completion) {
            self.completion();
        }
    }
}

+ (instancetype)popViewWithContentView:(UIView *)contentView {
    HXPopView *popView = [[HXPopView alloc] initWithFrame:KEY_WINDOW.bounds];
    contentView.center = popView.center;
    popView.contentView = contentView;
    [popView addSubview:contentView];
    return popView;
}

- (void)show {
    [KEY_WINDOW addSubview:self];
    [self displayAnimation];
}

- (void)dismiss {
    CABasicAnimation *basicAnimtion = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAnimtion.duration = 0.4;
    basicAnimtion.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4 :0.15 :0.5 :-0.7];
    basicAnimtion.fromValue = @1;
    basicAnimtion.toValue = @0;
    basicAnimtion.delegate = self;
    basicAnimtion.removedOnCompletion = NO;
    basicAnimtion.fillMode = kCAFillModeForwards;
    [self.contentView.layer addAnimation:basicAnimtion forKey:KEY_REVERSEANIMATION];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (anim == [self.contentView.layer animationForKey:KEY_REVERSEANIMATION]) {
        [self removeFromSuperview];
        self.contentView = nil;
    }
}

- (void)displayAnimation {
    CABasicAnimation *basicAnimtion = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    basicAnimtion.duration = 0.4;
    basicAnimtion.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5 :1.7 :0.6 :0.85];
    basicAnimtion.fromValue = @0;
    basicAnimtion.toValue = @1;
    [self.contentView.layer addAnimation:basicAnimtion forKey:KEY_ANIMATION];
}

@end
