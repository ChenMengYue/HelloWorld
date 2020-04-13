//
//  MenuOfPopTableCell.m
//  PointPenOfKunMing
//
//  Created by 陈梦悦 on 2018/4/12.
//  Copyright © 2018年 陈梦悦. All rights reserved.
//

#import "MenuOfPopTableCell.h"
#import "C_MacroOfConstants.h"
#import "CommonProjectDefines.h"
#import "UIImage+C_BundleResource.h"

@implementation MenuOfPopModel

@end

#define isMenuSystemView  0

@interface MenuOfPopTableCell(){
    MenuOfPopModel *popMenuModel;
}
@property(nonatomic,strong) UIImage *selectedImg;
@property(nonatomic,strong) UIImage *un_selectedImg;
@property(nonatomic,assign)PopMenuOfPosition menuPosition;

@property(nonatomic,strong)UILabel *lal_title;

#if isMenuSystemView
#else
@property(nonatomic,strong)UIImageView *bgIcon_imgV;

#endif
@end

@implementation MenuOfPopTableCell

+ (instancetype) cellAllocWithMenuTableView:(UITableView *)tableView position:(PopMenuOfPosition)position{
    
    MenuOfPopTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }

    [cell setMenuPosition:position];
    if (tableView.tag == 999) {
        cell.bgIcon_imgV.transform = CGAffineTransformMakeScale(-1, 1);
    }

    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=[UIColor clearColor];
        self.contentView.backgroundColor=[UIColor clearColor];
        _isShowSelectedState=NO;
#if isMenuSystemView
#else
        _bgIcon_imgV=[[UIImageView alloc]init];
//        [_bgIcon_imgV setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:_bgIcon_imgV];
#endif
        
//        _lal_title=[[UILabel alloc]init];
        _lal_title=self.textLabel;
        _lal_title.backgroundColor=[UIColor clearColor];
        _lal_title.font = C_FONTSIZE(15, 18);
        
        _lal_title.textColor=[UIColor whiteColor];
        _lal_title.textAlignment=NSTextAlignmentLeft;
//        [self addSubview:_lal_title];
        
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self sendSubviewToBack:_bgIcon_imgV];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType=UITableViewCellAccessoryNone;
    }
    return self;
}

-(void)reInitSubViewFrame{
#if isMenuSystemView
#else
    _bgIcon_imgV.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
#endif
    float titleMargin=(_menuPosition==PopMenuOfPosition_Top || _menuPosition==PopMenuOfPosition_All)?[MenuOfPopTableCell menuTopMarginHeight]:0;
//    float titleMargin=_menuPosition==PopMenuOfPosition_Top?[MenuOfPopTableCell menuTopMarginHeight]:0;
    CGRect frameTitle=_lal_title.frame;
    frameTitle.origin.y=titleMargin;
    frameTitle.size.height=self.frame.size.height-titleMargin;
    _lal_title.frame=frameTitle;
    
    CGRect frameImage=self.imageView.frame;
    frameImage.origin.y=titleMargin;
    frameImage.size.height=self.frame.size.height-titleMargin;
    self.imageView.frame=frameImage;
    
}


-(void)reInitMenuPopData:(MenuOfPopModel *)menuModel{
    popMenuModel=menuModel;
    self.lal_title.text = menuModel.title;
    if (C_StringIsEffective(menuModel.imageStr)) {
        self.imageView.image = [UIImage imageDefaultBundleNamed:menuModel.imageStr];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self reInitSubViewFrame];
}

-(UIImage *)selectedImg{
    if (!_selectedImg) {
        switch (_menuPosition) {
            case PopMenuOfPosition_Top:
            {
                _selectedImg=[UIImage imageDefaultBundleNamed:@"MenuPop/菜单栏-上-选中"];
            }
                break;
            case PopMenuOfPosition_Common:
            {
                _selectedImg=[UIImage imageDefaultBundleNamed:@"MenuPop/菜单栏-中-选中"];
            }
                break;
            case PopMenuOfPosition_Bottom:
            {
                _selectedImg=[UIImage imageDefaultBundleNamed:@"MenuPop/菜单栏-下-选中"];
            }
                break;
            case PopMenuOfPosition_All:
            {
                _selectedImg=[UIImage imageDefaultBundleNamed:@"MenuPop/菜单栏-全-选中"];
            }
                break;
            default:
                break;
        }
    }
    return _selectedImg;
}

-(UIImage *)un_selectedImg{
    if (!_un_selectedImg) {
        switch (_menuPosition) {
            case PopMenuOfPosition_Top:
            {
                _un_selectedImg=[UIImage imageDefaultBundleNamed:@"MenuPop/菜单栏-上-未选中"];
            }
                break;
            case PopMenuOfPosition_Common:
            {
                _un_selectedImg=[UIImage imageDefaultBundleNamed:@"MenuPop/菜单栏-中-未选中"];
            }
                break;
            case PopMenuOfPosition_Bottom:
            {
                _un_selectedImg=[UIImage imageDefaultBundleNamed:@"MenuPop/菜单栏-下-未选中"];
            }
                break;
            case PopMenuOfPosition_All:
            {
                _selectedImg=[UIImage imageDefaultBundleNamed:@"MenuPop/菜单栏-全-未选中"];
            }
                break;
            default:
                break;
        }
    }
    return _un_selectedImg;
}


-(void)setMenuPosition:(PopMenuOfPosition)menuPosition{
    _menuPosition=menuPosition;
    switch (_menuPosition) {
        case PopMenuOfPosition_Top:
        {
            _selectedImg=[UIImage imageDefaultBundleNamed:@"MenuPop/菜单栏-上-选中"];
            _un_selectedImg=[UIImage imageDefaultBundleNamed:@"MenuPop/菜单栏-上-未选中"];
        }
            break;
        case PopMenuOfPosition_Common:
        {
            _selectedImg=[UIImage imageDefaultBundleNamed:@"MenuPop/菜单栏-中-选中"];
            _un_selectedImg=[UIImage imageDefaultBundleNamed:@"MenuPop/菜单栏-中-未选中"];
        }
            break;
        case PopMenuOfPosition_Bottom:
        {
            _selectedImg=[UIImage imageDefaultBundleNamed:@"MenuPop/菜单栏-下-选中"];
            _un_selectedImg=[UIImage imageDefaultBundleNamed:@"MenuPop/菜单栏-下-未选中"];
        }
            break;
        case PopMenuOfPosition_All:
        {
            _selectedImg=[UIImage imageDefaultBundleNamed:@"MenuPop/菜单栏-全-选中"];
            _un_selectedImg=[UIImage imageDefaultBundleNamed:@"MenuPop/菜单栏-全-未选中"];

        }
            break;
        default:
            break;
    }
    [self resetBgImg];
}

-(void)setIsShowSelectedState:(BOOL)isShowSelectedState{
    _isShowSelectedState=isShowSelectedState;
    if (_bgIcon_imgV) {
        [self resetBgImg];
    }
}

#if 0  //原先正常的
-(void)resetBgImg{
#if isMenuSystemView
    [self setBackgroundColor:[UIColor colorWithPatternImage:self.selected?self.selectedImg:self.un_selectedImg]];
#else
    if (self.isShowSelectedState) {
        [_bgIcon_imgV setImage:self.selectedImg];
        [self.lal_title setTextColor:[UIColor whiteColor]];
        if (C_StringIsEffective(popMenuModel.selectedImgStr)) {
            self.imageView.image = [UIImage imageDefaultBundleNamed:popMenuModel.selectedImgStr];
        }else if (C_StringIsEffective(popMenuModel.imageStr)) {
            self.imageView.image = [UIImage imageDefaultBundleNamed:popMenuModel.imageStr];
        }

    }else{
        [_bgIcon_imgV setImage:self.un_selectedImg];
        [self.lal_title setTextColor:[UIColor fontColorOfMainBlackStyle]];
        if (C_StringIsEffective(popMenuModel.imageStr)) {
            self.imageView.image = [UIImage imageDefaultBundleNamed:popMenuModel.imageStr];
        }
    }

#endif
}

#else



-(void)resetBgImg{
#if isMenuSystemView
    [self setBackgroundColor:[UIColor colorWithPatternImage:self.selected?self.selectedImg:self.un_selectedImg]];
#else
   

    if (self.isShowSelectedState) {
        [_bgIcon_imgV setImage:[self.un_selectedImg imageOfChangeToTintColor:[UIColor colorWithWhite:0 alpha:.4]]];
        [self.lal_title setTextColor:[UIColor fontColorOfMainBlackStyle]];
        if (C_StringIsEffective(popMenuModel.imageStr)) {
            self.imageView.image = [UIImage imageDefaultBundleNamed:popMenuModel.imageStr];
        }else if (C_StringIsEffective(popMenuModel.selectedImgStr)) {
            self.imageView.image = [UIImage imageDefaultBundleNamed:popMenuModel.selectedImgStr];
        }

    }else{
        [_bgIcon_imgV setImage:[self.selectedImg imageOfChangeToTintColor:[UIColor colorWithWhite:0 alpha:.8]]];
        [self.lal_title setTextColor:[UIColor whiteColor]];
        if (C_StringIsEffective(popMenuModel.selectedImgStr)) {
            self.imageView.image = [[UIImage imageDefaultBundleNamed:popMenuModel.selectedImgStr] imageOfChangeToTintColor:[UIColor colorWithWhite:0 alpha:.8]];
        }
    }

#endif
}

#endif
- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+(float)menuTopMarginHeight{
       return adapterWidth(2, 8, 12);
}

+(float)menuPopCellHeight:(PopMenuOfPosition)position{
    if (position==PopMenuOfPosition_Top ||position==PopMenuOfPosition_All) {
        return adapterHeigth(2, 44, 66)+[self menuTopMarginHeight];

    }
    if (position==PopMenuOfPosition_Bottom) {
        return adapterHeigth(2, 44, 66)+[self menuTopMarginHeight];
    }
    return adapterHeigth(2, 44, 66);
}



@end
