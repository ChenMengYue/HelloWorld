//
//  DropDownButton.m
//  lyxCRM
//
//  Created by upplus_Cmy on 2019/10/25.
//  Copyright © 2019 liang yan. All rights reserved.
//

#import "DropDownButton.h"
#import "UIColor+C_Constants.h"
#import "Masonry.h"
#import "C_MacroOfConstants.h"


@interface DropDownButton ()
{
    UIImage *selectedImg;
    UIImage *unSelectedImg;
    UIColor *normalStateColor;
    UIColor *selectedStateColor;
    
}

@property(nonatomic,strong)UILabel *lalTitle;
@property(nonatomic,strong)UIImageView *imgvIcon;

@end

@implementation DropDownButton


-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        _lalTitle=[[UILabel alloc]initWithFrame:CGRectZero];
        _lalTitle.textAlignment=NSTextAlignmentCenter;
        _lalTitle.textColor=[UIColor fontColorOfMainBlackStyle];
        _lalTitle.font=C_FONTSIZE(16,18);
        [self addSubview:_lalTitle];
        
        
        _imgvIcon=[[UIImageView alloc]initWithFrame:CGRectZero];
        [self addSubview:_imgvIcon];
        
        [_imgvIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(widthAdapterBack(18), widthAdapterBack(18)));
            make.right.equalTo(self.mas_right).offset(-widthAdapterBack(8));
        }];
        
        [_lalTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.equalTo(self);
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left).offset(widthAdapterBack(12));
            make.right.equalTo(self.imgvIcon.mas_left).offset(-widthAdapterBack(5));

        }];
        
        
    }
    return self;
}

-(void)setDownImage:(UIImage *)downImage upImage:(UIImage *)upImage{
    selectedImg=upImage;
    unSelectedImg=downImage;
    [self reloadShowImage];
    
}

-(void)setNormalTextColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor{
    selectedStateColor=selectedColor;
    normalStateColor=normalColor;
    [self reloadShowText];
    
}

-(void)reloadShowImage{
    [_imgvIcon setImage:self.selected?selectedImg:unSelectedImg];
    
    
}
-(void)reloadShowText{
    _lalTitle.textColor=self.selected?selectedStateColor:normalStateColor;
    
}

-(void)setTitle:(NSString *)title{
    _title=[title copy];
    _lalTitle.text=title;

}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    [self reloadShowText];
    [self reloadShowImage];

}

-(void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    _lalTitle.textColor=enabled?normalStateColor:_disableColor;

}


@end
