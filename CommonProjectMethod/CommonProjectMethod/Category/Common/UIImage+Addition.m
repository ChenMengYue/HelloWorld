//
//  UIImage+Addition.m
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/7.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//

#import "UIImage+Addition.h"
#import "CommonProjectDefines.h"

@implementation UIImage (Addition)

+(UIImage *)imageWithColor:(UIColor *)convertColor
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[convertColor CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

-(UIImage *)imageOfChangeToTintColor:(UIColor *)tintColor
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);

    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];

    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return tintedImage;
}

+(UIImage *)originalImageNamed:(NSString *)name
{
    return [[UIImage imageNamed:name]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


+(UIImage *)imageOfGradientFrom:(CGSize)viewSize colors:(NSMutableArray *)colors isHor:(BOOL)isHor {
    return [self imageOfGradientFrom:viewSize colors:colors startPoint:isHor?CGPointMake(0.0, 0.1):CGPointMake(0.1, 0.0) endPoint:isHor?CGPointMake(1.0, 0.1):CGPointMake(0.1, 1.0)];
}

+(UIImage *)imageOfGradientFrom:(CGSize)viewSize colors:(NSMutableArray *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    CAGradientLayer *graLayer=[CAGradientLayer layer];
    graLayer.borderWidth=0;
    graLayer.frame=CGRectMake(0, 0, viewSize.width, viewSize.height);
    NSMutableArray *graColors=[NSMutableArray array];
    for (UIColor *tmpColor in colors) {
        [graColors addObject: (id)[tmpColor CGColor]];
    }
    graLayer.colors=graColors;
    graLayer.startPoint =startPoint;
    graLayer.endPoint = endPoint;
    
    UIGraphicsBeginImageContext(graLayer.frame.size);
    [graLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return aimg;
}


+(UIImage *)bundleImageNamed:(NSString *)name bundle:(NSString *)bundleName directorName:(nullable NSString *)director
{
    NSMutableString *path =[NSMutableString stringWithString:[[NSBundle mainBundle]pathForResource:bundleName ofType:@"bundle"]];
    
    if (C_StringIsEffective(director)) {
        [path appendString:[NSString stringWithFormat:@"/%@",director]];
    }
    //[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Resources.bundle/Resources"];
       
    NSString *filepath = [path stringByAppendingPathComponent:name];
    return [UIImage imageWithContentsOfFile:filepath];
}


@end
