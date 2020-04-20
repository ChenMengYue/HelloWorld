//
//  UIImage+C_BundleResource.h
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/8.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (C_BundleResource)


+(UIImage *)imageDefaultBundleNamed:(NSString *)imageName;


+(UIImage *)imageOfFrameWork:(NSString *)framework bundleName:(NSString *)bundleName imageName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
