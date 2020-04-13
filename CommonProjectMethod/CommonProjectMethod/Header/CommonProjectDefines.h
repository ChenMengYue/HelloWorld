//
//  CommonProjectDefines.h
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/7.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//

#ifndef CommonProjectDefines_h
#define CommonProjectDefines_h

#import "CmyAppAdapterScreenUtil.h"

#define C_DEVICE_IS_IPHONE    ([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone)

#pragma mark -------------以下是宽高度相关-----------------------
#define C_SCREEN_WIDTH   ([UIScreen mainScreen].bounds.size.width)
#define C_SCREEN_HEIGHT  ([UIScreen mainScreen].bounds.size.height)


//状态栏高度
#define C_IS_IPHONE_X        (C_SCREEN_HEIGHT >= 812.0)                                           //是否X机型

#define C_Height_SatusBar    (C_IS_IPHONE_X ? 44 : 20)//(44/20)
#define C_Height_TabBar      (C_IS_IPHONE_X ? (49.0 + 34.0) : (49.0))                      //标签栏高度
#define C_Height_Phone_Home_Indicator  (C_DEVICE_IS_IPHONE?(C_IS_IPHONE_X ? 34:0):0)

#define C_IS_LATER_IPHONE_X  ((C_Height_SatusBar == 44.0) ? YES : NO)


#pragma mark -------------以下是字符串处理-----------------

//字符串
#pragma mark - utils
#define Locale(str)            NSLocalizedString(str, nil)

#pragma mark - 有效性校验
#define C_StringIsNilOfNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) || ([(_ref) isKindOfClass:[NSNull class]]) )

#define C_StringIsEffective(_ref)      ((C_StringIsNilOfNull(_ref)==NO) && ([[_ref stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]>0))

#define C_StringUseful(_ref)     ((C_StringIsNilOfNull(_ref)==NO) && ![_ref isEqualToString:@"null"])?[_ref stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]:@""


#pragma mark -------------以下是字体大小相关-----------------------


#if isAdapterIpad
#define C_SYSTEM_FONT_(x)                    [UIFont systemFontOfSize:x]
#define C_SYSTEM_FONT_BOLD_(a)               [UIFont boldSystemFontOfSize:a]

#define C_FONTSIZE(fontIphone,fontIpad)      [UIFont systemFontOfSize:(DEVICE_IS_IPHONE?fontIphone:fontIpad)]
#define C_FONTBOLDSIZE(fontIphone,fontIpad)  [UIFont boldSystemFontOfSize:(DEVICE_IS_IPHONE?fontIphone:fontIpad)]

#else

#define C_FONTSIZE(fontIphone,fontIpad)      [UIFont systemFontOfSize:fontIphone]
#define C_FONTBOLDSIZE(fontIphone,fontIpad)  [UIFont boldSystemFontOfSize:fontIphone]

#endif


#pragma mark -------------------适配屏幕相关--------------------

#define width(width)    (width)
#define height(height)  (height)


#define widthAdapterBack(width)   (widthCompatibility(width,CompatibilityModeTypeBackWards))
#define heightAdapterBack(height)   (heightCompatibility(height,CompatibilityModeTypeBackWards))


#define widthAdapterAll(width)   (widthCompatibility(width,CompatibilityModeTypeAll))
#define heightAdapterAll(height)   (heightCompatibility(height,CompatibilityModeTypeAll))

#define isAdatpterIpad  1

#if isAdatpterIpad

//type 1:width(width)    2:widthAdapterBack(width)  3:widthAdapterAll(width)

#define adapterWidth(type,iphone,ipad)  (type==1?width(C_DEVICE_IS_IPHONE?iphone:ipad):type==2?widthAdapterBack(C_DEVICE_IS_IPHONE?iphone:ipad):widthAdapterAll(C_DEVICE_IS_IPHONE?iphone:ipad))

#define adapterHeigth(type,iphone,ipad)      (type==1?height(C_DEVICE_IS_IPHONE?iphone:ipad):type==2?heightAdapterBack(C_DEVICE_IS_IPHONE?iphone:ipad):heightAdapterAll(C_DEVICE_IS_IPHONE?iphone:ipad))

#else

//type 1:width(width)    2:widthAdapterBack(width)  3:widthAdapterAll(width)
#define adapterWidth(type,iphone,ipad)          (type==1?width(iphone):type==2?widthAdapterBack(iphone):widthAdapterAll(iphone))
#define adapterHeigth(type,iphone,ipad)         (type==1?height(iphone):type==2?heightAdapterBack(iphone):heightAdapterAll(iphone))

#endif


#endif /* CommonProjectDefines_h */
