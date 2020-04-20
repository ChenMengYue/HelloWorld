//
//  APPUtil.h
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/9.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APPUtil : NSObject

+ (void)callWithPhone:(NSString *)phone;


+(NSBundle *)getResourceByFramework:(NSString *)frameworkName resourceName:(NSString *)resourceName;
@end

NS_ASSUME_NONNULL_END
