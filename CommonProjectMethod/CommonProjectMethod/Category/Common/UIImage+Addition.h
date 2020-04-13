//
//  UIImage+Addition.h
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/7.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Addition)

+(UIImage *)imageWithColor:(UIColor *)convertColor;

/*修改图片的颜色*/
-(UIImage *)imageOfChangeToTintColor:(UIColor *)tintColor;

+(UIImage *)originalImageNamed:(NSString *)name;

+(UIImage *)imageOfGradientFrom:(CGSize)viewSize colors:(NSMutableArray *)colors isHor:(BOOL)isHor;

+(UIImage *)imageOfGradientFrom:(CGSize)viewSize colors:(NSMutableArray *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;


+(UIImage *)bundleImageNamed:(NSString *)name bundle:(NSString *)bundleName directorName:(nullable NSString *)director;

@end

NS_ASSUME_NONNULL_END
