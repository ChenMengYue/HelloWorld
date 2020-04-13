//
//  CmyAppAdapterScreenUtil.h
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/7.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CoreGraphics/CGGeometry.h>
#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

#pragma mark -

typedef NS_ENUM(NSInteger,ReferenceScreen)
{
    ReferenceScreeniPhone5s,
    ReferenceScreeniPhoneSE,
    ReferenceScreeniPhone6,
    ReferenceScreeniPhone6Plus,
    ReferenceScreeniPhone6s,
    ReferenceScreeniPhone6sPlus,
    ReferenceScreeniPhone7,
    ReferenceScreeniPhone7Plus,
    ReferenceScreeniPhone8,
    ReferenceScreeniPhoneX,
    ReferenceScreeniPhoneXR,
    ReferenceScreeniPhoneXS,//后续补充，
};


typedef NS_ENUM(NSUInteger, CompatibilityModeType) {
    CompatibilityModeTypeNone,//不兼容
    CompatibilityModeTypeBackWards,//向下兼容屏幕尺寸
//    CompatibilityModeTypeUpward,//向上兼容
    CompatibilityModeTypeAll,//兼容全部
};



//适配用下面的宏定义，不用类的实例方法，可以统一更改
#define appAdatapterReferenceScreen(referenceScreen) [CmyAppAdapterScreenUtil setReferenceScreen:(referenceScreen)]

CGRect CGRectMakeCompatibility(CGFloat x, CGFloat y, CGFloat width, CGFloat height,CompatibilityModeType type);

CGSize CGSizeMakeCompatibility(CGFloat width, CGFloat height,CompatibilityModeType type);

CGPoint CGPointMakeCompatibility(CGFloat x, CGFloat y,CompatibilityModeType type);

double heightCompatibility(double height,CompatibilityModeType type);

double widthCompatibility(double width,CompatibilityModeType type);


@interface CmyAppAdapterScreenUtil : NSObject
@property(nonatomic,assign) float autoSizeScaleX;
@property(nonatomic,assign) float autoSizeScaleY;

@property(nonatomic,assign,readonly)BOOL isAdapterBackWards;

+ (instancetype)shareAPPAdapterInstance;

/**
 设置效果图参考价值
 @param width 参考宽度
 @param height 参考高度
 */
- (void)setReference:(CGFloat)width height:(CGFloat)height;


/**
 设置效果图参考屏幕
 
 @param referenceScreen 参考屏幕
 */
+ (void)setReferenceScreen:(ReferenceScreen)referenceScreen;


/**
 水平位置换算
 @param x 换算前水平位置/宽度
 @return  换算后水平位置/宽度
 */
- (CGFloat)adapterX:(CGFloat)x;

/**
 垂直位置换算
 @param y 换算前垂直位置/高度
 @return  换算后垂直位置/高度
 */
- (CGFloat)adapterY:(CGFloat)y;

@end

NS_ASSUME_NONNULL_END
