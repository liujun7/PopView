//
//  HXPopView.h
//  ExampleDemo
//
//  Created by 刘军 on 2017/3/23.
//  Copyright © 2017年 hxzq. All rights reserved.
// 提供弹出视图的弹出效果，具体内容视图需要自定义

#import <UIKit/UIKit.h>

typedef void (^TapCompletionBlock)();

@interface HXPopView : UIView

/** *是否可点击消失 默认为 YES */
@property (nonatomic, assign) BOOL canTapDismiss;

/** *点击消失后的回调代码块 */
@property (nonatomic, copy) TapCompletionBlock completion;

/**
 类方法创建HXPopView实例

 @param contentView 需要显示的内容视图
 @return 返回HXPopView实例
 */
+ (instancetype)popViewWithContentView:(UIView *)contentView;

/**
 创建对象后调用此方法显示
 */
- (void)show;

@end
