//
//  APPUtil.m
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/9.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//

#import "APPUtil.h"

#import <UIKit/UIKit.h>

@implementation APPUtil

/**
 拨打电话
 
 @param phone 电话号码
 */
+ (void)callWithPhone:(NSString *)phone
{
    NSMutableString *phoneString = [[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneString] options:@{} completionHandler:^(BOOL success) {
        }];
    } else {
        // Fallback on earlier versions
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneString]];
    }
}

+(NSString *)getFrameworkPathByName:(NSString *)frameworkName{
    return [[NSBundle mainBundle] pathForResource:frameworkName ofType:@"framework"];
}

+(NSBundle *)getFrameWorkBundleByName:(NSString *)frameworkName{
    return [NSBundle bundleWithPath:[self getFrameworkPathByName:frameworkName]];
}

+(NSBundle *)getResourceByFramework:(NSString *)frameworkName resourceName:(NSString *)resourceName{
    return [NSBundle bundleWithPath:[[NSBundle bundleWithPath:[self getFrameworkPathByName:frameworkName]] pathForResource:resourceName ofType:@"bundle"]];
}

@end
