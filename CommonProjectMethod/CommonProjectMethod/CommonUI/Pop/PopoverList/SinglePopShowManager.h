//
//  SinglePopShowManager.h
//  MIMA
//
//  Created by 陈梦悦 on 2019/7/22.
//  Copyright © 2019 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol SinglePopShowManagerDelegate <NSObject>

-(void)onSinglePopViewDismissed:(UIView *)showPopView;

@end


@interface SinglePopShowManager : NSObject

+ (SinglePopShowManager *) shareSingleShowManager;

@property(nonatomic,weak)id<SinglePopShowManagerDelegate> delegate;

/*
 *compareView：popoview的父类，用于控制popoview的显示位置，默认为父类的中心位置
 *showBgCtr：背景，控制背景颜色，是否可点击等
 */
-(void)showPopoverView:(UIView *)showView superView:(nullable UIView *)showSuperView showBlock:(void(^)(UIView *compareView,UIControl *showBgCtr))block;

- (void) hideShowView ;
- (void)hideShowViewWithoutAnimate;

@end

NS_ASSUME_NONNULL_END
