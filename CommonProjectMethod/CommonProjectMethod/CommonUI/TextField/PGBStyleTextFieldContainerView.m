//
//  PGBStyleTextFieldContainerView.m
//  PaiGongBao
//
//  Created by 陈梦悦 on 2019/8/1.
//  Copyright © 2019 cmy. All rights reserved.
//

#import "PGBStyleTextFieldContainerView.h"
#import "Masonry.h"
#import "C_MacroOfConstants.h"
#import "PGBSendCodeButton.h"


@interface PGBStyleTextFieldContainerView ()

@property(nonatomic,copy)PGBStyleTextFieldViewModel *viewModel;

@property(nonatomic,strong)UILabel *lalTitle;
@property(nonatomic,strong)UIImageView *imgVIcon;
@property(nonatomic,strong)PGBSendCodeButton *sendCodeBtn;


@end

@implementation PGBStyleTextFieldContainerView



-(instancetype)initWithFrame:(CGRect)frame viewModel:(PGBStyleTextFieldViewModel *)viewModel{
    self=[super initWithFrame:frame];
    if (self) {
        _viewModel=viewModel;
        [self loadMainView];
        if (_viewModel.refreshFrameBlock) {
            _viewModel.refreshFrameBlock(self, self.containView);
        }
        
    }
    return self;
}




-(UIView *)containView{
    
    switch (_viewModel.viewType) {
        case PGBStyleTextFieldViewTypeNone:
        {
            
        }
            break;
        case PGBStyleTextFieldViewTypeIcon:
        {
            
            return self.imgVIcon;
            
        }
            break;
        case PGBStyleTextFieldViewTypeTitle:
        {
            return self.lalTitle;
        }
            break;
        case PGBStyleTextFieldViewTypeSendCode:
        {
            return self.sendCodeBtn;
        }
            break;
        default:
            break;
    }
    return nil;
    
}


-(void)loadMainView{
    
    switch (_viewModel.viewType) {
        case PGBStyleTextFieldViewTypeNone:
        {
            
        }
            break;
        case PGBStyleTextFieldViewTypeIcon:
        {
            
            [self addSubview:self.imgVIcon];
            [self.imgVIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
                make.left.equalTo(self.mas_left).offset(widthAdapterAll(8));
//                make.width.mas_equalTo(widthAdapterAll(30));

            }];
            [self.imgVIcon setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
            
        }
            break;
        case PGBStyleTextFieldViewTypeTitle:
        {
            [self addSubview:self.lalTitle];
            [self.lalTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
                make.left.equalTo(self.mas_left).offset(widthAdapterAll(5));
                make.right.equalTo(self.mas_right).offset(-widthAdapterAll(5));
                make.width.mas_greaterThanOrEqualTo(widthAdapterBack(30));
            }];
            [self.lalTitle setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];

        }
            break;
        case PGBStyleTextFieldViewTypeSendCode:
        {
            [self addSubview:self.sendCodeBtn];
            [self.sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
                make.right.equalTo(self.mas_right).offset(widthAdapterBack(8));
                make.top.equalTo(self.mas_top).offset(widthAdapterBack(8));
                make.width.mas_equalTo(widthAdapterBack(85));
            }];
            [self.sendCodeBtn setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];

        }
            break;
        default:
            break;
    }

}



-(UILabel *)lalTitle{
    if (!_lalTitle) {
        _lalTitle=[[UILabel alloc]initWithFrame:CGRectZero];
        _lalTitle.textColor=[UIColor colorWithHex:0x7A7A7A];
        _lalTitle.font=C_FONTSIZE_COMMON;
        _lalTitle.textAlignment=NSTextAlignmentCenter;
        _lalTitle.text=_viewModel.typeAttribute;

    }
    return _lalTitle;
    
}

-(UIImageView *)imgVIcon{
    if (!_imgVIcon) {
        _imgVIcon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:_viewModel.typeAttribute]];
    }
    return _imgVIcon;
}

-(PGBSendCodeButton *)sendCodeBtn{
    if (!_sendCodeBtn) {
        _sendCodeBtn=[[PGBSendCodeButton alloc]initWithFrame:CGRectZero];
        _sendCodeBtn.codeType=_viewModel.sendCodeType;
        if (C_StringIsEffective(_viewModel.typeAttribute)) {
            _sendCodeBtn.normalTitle=C_StringUseful(_viewModel.typeAttribute);
        }
    }
    return _sendCodeBtn;
}


@end
