//
//  DropDownButton.h
//  lyxCRM
//
//  Created by upplus_Cmy on 2019/10/25.
//  Copyright © 2019 liang yan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DropDownButton : UIControl


@property(nonatomic,strong,readonly)UILabel *lalTitle;
@property(nonatomic,copy)NSString *title;

@property(nonatomic,strong)UIColor *disableColor;

-(void)setDownImage:(UIImage *)downImage upImage:(UIImage *)upImage;

-(void)setNormalTextColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor;

@end

NS_ASSUME_NONNULL_END
