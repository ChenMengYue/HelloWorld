//
//  NSString+Attribution.h
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/7.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Attribution)

-(NSMutableAttributedString *)getAttributeStyleByTextAlignment:(NSTextAlignment)alignment font:(UIFont *)font color:(UIColor *)textColor lineSpace:(float)lineSpace textSpace:(float)textSpace;

-(NSMutableAttributedString *)getAttributeStyleByTextFont:(UIFont *)font color:(UIColor *)textColor lineSpace:(float)lineSpace textSpace:(float)textSpace;

-(CGSize)getHeightOfAttrTextByTextFont:(UIFont *)font color:(UIColor *)textColor lineSpace:(float)lineSpace textSpace:(float)textSpace width:(float)textWidth;
@end

NS_ASSUME_NONNULL_END
