//
//  CmyAppAdapterScreenUtil.m
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/7.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//

#import "CmyAppAdapterScreenUtil.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "CommonProjectDefines.h"

static CmyAppAdapterScreenUtil *_instance;

//#define MyUIDesignScreenWidth 375 // UI设计原型图的手机尺寸宽度(6), 6p的--414
//#define MyUIDesignScreenHeight 667 // UI设计原型图的手机尺寸宽度(6), 6p的--414
#define MyUIDesignScreenWidth 414 // UI设计原型图的手机尺寸宽度(6), 6p的--414
#define MyUIDesignScreenHeight 667 // UI设计原型图的手机尺寸宽度(6), 6p的--414


#define SCREEN_HEIGHT_MAX   MAX([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)
#define SCREEN_WIDTH_MIN   MIN([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)



#define appAdatapterReference(w,h) [[CmyAppAdapterScreenUtil shareAPPAdapterInstance] setReference:(w) height:(h)]
#define appAdatapterGetIsBackWards ([CmyAppAdapterScreenUtil shareAPPAdapterInstance].isAdapterBackWards)

#define adapterX(x) [[CmyAppAdapterScreenUtil shareAPPAdapterInstance] adapterX:(x)]
#define adapterY(y) [[CmyAppAdapterScreenUtil shareAPPAdapterInstance] adapterY:(y)]



CGRect CGRectMakeCompatibility(CGFloat x, CGFloat y, CGFloat width, CGFloat height,CompatibilityModeType type)
{
    BOOL isAdapter=type==CompatibilityModeTypeAll || (type==CompatibilityModeTypeBackWards && appAdatapterGetIsBackWards) ;
    
    if (isAdapter) {
        CGRect rect;
        rect.origin.x = adapterX(x);
        rect.origin.y =adapterY(y);
        rect.size.width = adapterX(width);
        rect.size.height = adapterY(height);
        return rect;
    }
    CGRect rect;
    rect.origin.x = x;
    rect.origin.y =y;
    rect.size.width = width;
    rect.size.height = height;
    return rect;
    
}

CGSize CGSizeMakeCompatibility(CGFloat width, CGFloat height,CompatibilityModeType type)
{
    
    BOOL isAdapter=type==CompatibilityModeTypeAll || (type==CompatibilityModeTypeBackWards && appAdatapterGetIsBackWards) ;
    
    if (isAdapter) {
        CGSize size;
        size.width = adapterX(width);
        size.height = adapterY(height);
        return size;
    }
    CGSize size;
    size.width = width;
    size.height = height;
    return size;
}
CGPoint CGPointMakeCompatibility(CGFloat x, CGFloat y,CompatibilityModeType type)
{
    BOOL isAdapter=type==CompatibilityModeTypeAll || (type==CompatibilityModeTypeBackWards && appAdatapterGetIsBackWards) ;
    if (isAdapter) {
        CGPoint point;
        point.x = adapterX(x);
        point.y =adapterY(y);
        return point;
    }
    CGPoint point;
    point.x = x;
    point.y =y;
    return point;
}
//适配高度
double heightCompatibility(double height,CompatibilityModeType type)
{
    BOOL isAdapter=type==CompatibilityModeTypeAll || (type==CompatibilityModeTypeBackWards && appAdatapterGetIsBackWards) ;

    if (isAdapter) {
        return adapterY(height);
    }
    return height;
}
//适配宽度
double widthCompatibility(double width,CompatibilityModeType type)
{
    BOOL isAdapter=type==CompatibilityModeTypeAll || (type==CompatibilityModeTypeBackWards && appAdatapterGetIsBackWards) ;
    if (isAdapter) {
        return adapterX(width);
    }
    return width;
}



@interface CmyAppAdapterScreenUtil ()
/**(效果图)参考屏幕宽*/
@property (nonatomic, assign) CGFloat referenceWidth;

/**(效果图)参考屏幕高*/
@property (nonatomic, assign) CGFloat referenceHeight;

@property(nonatomic,assign)BOOL isAdapterBackWards;

@end

@implementation CmyAppAdapterScreenUtil

+ (instancetype)shareAPPAdapterInstance
{
    if (_instance == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[self alloc] init];
        });
    }
    return _instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.referenceHeight = SCREEN_HEIGHT_MAX;
        self.referenceWidth = SCREEN_WIDTH_MIN;
        self.autoSizeScaleX = 1.0;
        self.autoSizeScaleY = 1.0;
        self.isAdapterBackWards=NO;
    }
    return self;
}


#pragma mark - 基础设置
- (void)setReference:(CGFloat)width height:(CGFloat)height
{
    self.referenceWidth = width;
    self.referenceHeight = height;
    
    self.autoSizeScaleX=SCREEN_WIDTH_MIN/self.referenceWidth;
    self.autoSizeScaleY=SCREEN_HEIGHT_MAX/self.referenceHeight;
    
    self.isAdapterBackWards=self.autoSizeScaleX<1;

}


/**
 * 不同机型的宽度  4/4s 5/5s 320  6/6s/7 375  6p/6sp/7p 414
 *
 *
 * 不同机型的高度 4/4s 480 5/5s 568  6/6s/7 667  6p/6sp/7p 736
 */

+ (void)setReferenceScreen:(ReferenceScreen)referenceScreen
{
    if (!C_DEVICE_IS_IPHONE) {
        appAdatapterReference(768, 1024);
        return;
    }
    
    switch (referenceScreen) {
        case ReferenceScreeniPhone5s:
        case ReferenceScreeniPhoneSE:
        {
            appAdatapterReference(320, 568);
        }
            break;
        case ReferenceScreeniPhone6:
        case ReferenceScreeniPhone6s:
        case ReferenceScreeniPhone7:
        case ReferenceScreeniPhone8:
        {
            appAdatapterReference(375, 667);
        }
            break;
        case ReferenceScreeniPhone6Plus:
        case ReferenceScreeniPhone6sPlus:
        case ReferenceScreeniPhone7Plus:
        {
            appAdatapterReference(414, 736);
        }
            break;
        case ReferenceScreeniPhoneX:
        {
            appAdatapterReference(375, 812);
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 尺寸换算

- (CGFloat)adapterX:(CGFloat)x
{
    return self.autoSizeScaleX * x;
}

- (CGFloat)adapterY:(CGFloat)y
{
    return self.autoSizeScaleY * y;
}




@end
