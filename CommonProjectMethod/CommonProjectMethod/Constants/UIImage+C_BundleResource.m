//
//  UIImage+C_BundleResource.m
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/8.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//

#import "UIImage+C_BundleResource.h"


@implementation UIImage (C_BundleResource)


+(UIImage *)imageNamed:(NSString *)imageName bundle:(NSString *)bundle{
//        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Resources.bundle/Resources"];
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle",bundle]];
      
    NSString *filepath = [path stringByAppendingPathComponent:imageName];
//        if ([[NSFileManager defaultManager]fileExistsAtPath:filepath]) {
//            return image;
//        }
        UIImage *image = [UIImage imageWithContentsOfFile:filepath];
        if (image) {
            return image;
        }
        NSString *realImageName=[[imageName componentsSeparatedByString:@"/"] lastObject];
        return [self imageNamed:realImageName];
}

//+(UIImage *)imageNamed:(NSString *)imageName bundle:(NSString *)bundle direct:(NSString *)directUrl{
//    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle",bundle]];
//      
//    NSString *filepath = [path stringByAppendingPathComponent:imageName];
//        UIImage *image = [UIImage imageWithContentsOfFile:filepath];
//        if (image) {
//            return image;
//        }
//        NSString *realImageName=[[imageName componentsSeparatedByString:@"/"] lastObject];
//        return [self imageNamed:realImageName];
//}

+(UIImage *)imageDefaultBundleNamed:(NSString *)imageName{
    return [self imageNamed:imageName bundle:@"ImageResource"];
}



@end
