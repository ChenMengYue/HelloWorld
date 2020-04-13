//
//  PGBStyleTextFieldView.m
//  PaiGongBao
//
//  Created by 陈梦悦 on 2019/7/31.
//  Copyright © 2019 cmy. All rights reserved.
//

#import "PGBStyleTextField.h"
#import "Masonry.h"
#import "C_MacroOfConstants.h"
#import "UITextField+C_Utils.h"
#import "NSString+Validation.h"

#pragma mark - PGBStyleTextFieldView

@interface PGBStyleTextField ()<UITextFieldDelegate>
{
    PGBStyleTextFieldShowModel *styleShowModel;
}

@property(nonatomic,strong)UIView *lineView;


@property(nonatomic,strong)PGBStyleTextFieldContainerView *leftView;
@property(nonatomic,strong)PGBStyleTextFieldContainerView *rightView;


@end

@implementation PGBStyleTextField



-(instancetype)initWithFrame:(CGRect)frame showModel:(PGBStyleTextFieldShowModel *)showModel{
    self=[super initWithFrame:frame];
    if (self) {
        styleShowModel=showModel;
        [self setUpViews];

        self.mainTxtF.placeholder=styleShowModel.placeHolder;
        //        [styleShowModel addObserver:<#(nonnull NSObject *)#> forKeyPath:@"placeHolder" options:<#(NSKeyValueObservingOptions)#> context:nil];


    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame showModel:(PGBStyleTextFieldShowModel *)showModel block:(validyStringIsEffective)validyRegular{
    self=[self initWithFrame:frame showModel:showModel];
    if (self) {
        self.validyRegular = validyRegular;
    }
    return self;
}

-(void)setWidthOfLeftView:(float)widthOfLeftView{
    _widthOfLeftView=widthOfLeftView;
    
    if (!styleShowModel.txtFLeftViewModel) {
        return;
    }
    
    [self.leftView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(widthOfLeftView);
    }];
    
//    [self.mainTxtF mas_remakeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.bottom.equalTo(self);
//        make.height.mas_greaterThanOrEqualTo(widthAdapterBack(38));
//        if (self.leftView && isShow) {
//            make.left.equalTo(self.leftView.mas_right).offset(widthAdapterBack(4));
//        }else{
//            make.left.equalTo(self.mas_left).offset(marginLeft);
//        }
//        if (self.rightView) {
//            make.right.equalTo(self.rightView.mas_left).offset(-widthAdapterBack(4));
//        }else{
//            make.right.equalTo(self.mas_right).offset(-marginLeft);
//        }
//    }];
}


-(void)changeContainerViewShowState:(BOOL)isShow isLeft:(BOOL)isLeft{
    
    float  marginLeft=16;
  
    if (isLeft) {
        if (!styleShowModel.txtFLeftViewModel) {
            return;
        }
        
        [self.leftView setHidden:!isShow];
        
        [self.mainTxtF mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.equalTo(self);
            make.height.mas_greaterThanOrEqualTo(widthAdapterBack(38));
            if (self.leftView && isShow) {
                make.left.equalTo(self.leftView.mas_right).offset(widthAdapterBack(4));
            }else{
                make.left.equalTo(self.mas_left).offset(marginLeft);
            }
            if (self.rightView) {
                make.right.equalTo(self.rightView.mas_left).offset(-widthAdapterBack(4));
            }else{
                make.right.equalTo(self.mas_right).offset(-marginLeft);
            }
        }];

        return;
    }else{
        if (!styleShowModel.txtFRightViewModel) {
            return;
        }
        [self.rightView setHidden:!isShow];
        
        [self.mainTxtF mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.equalTo(self);
            make.height.mas_greaterThanOrEqualTo(widthAdapterBack(38));
            if (self.leftView) {
                make.left.equalTo(self.leftView.mas_right).offset(widthAdapterBack(4));
            }else{
                make.left.equalTo(self.mas_left).offset(marginLeft);
            }
            if (self.rightView && isShow) {
                make.right.equalTo(self.rightView.mas_left).offset(-widthAdapterBack(4));
            }else{
                make.right.equalTo(self.mas_right).offset(-marginLeft);
            }
        }];

    }
    

    
    
}

-(void)setUpViews{
    
    float  marginLeft=16;

    
    if (styleShowModel.txtFLeftViewModel) {
        _leftView=[[PGBStyleTextFieldContainerView alloc]initWithFrame:CGRectZero viewModel:styleShowModel.txtFLeftViewModel];
        [self addSubview:_leftView];
        
        [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.mas_left).offset(marginLeft);
            
        }];
        
    }
    
    if (styleShowModel.txtFRightViewModel) {
        _rightView=[[PGBStyleTextFieldContainerView alloc]initWithFrame:CGRectZero viewModel:styleShowModel.txtFRightViewModel];
        [self addSubview:_rightView];
        [_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.equalTo(self.mas_right).offset(-marginLeft);
            
        }];
    }
    
    _mainTxtF=[[UITextField alloc]initWithFrame:CGRectZero];
//    [_mainTxtF setPlaceHolderColor:[UIColor colorWithHex:0xB6B6B6]];
//    [_mainTxtF setPlaceHolderFont:FontCommonMiddle];
    _mainTxtF.textColor=[UIColor fontColorOfMainGrayStyle];
    _mainTxtF.font=C_FONTSIZE_LARGE;
    _mainTxtF.delegate=self;
    _mainTxtF.clearButtonMode=UITextFieldViewModeWhileEditing;
    [_mainTxtF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_mainTxtF];

    [self.mainTxtF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.height.mas_greaterThanOrEqualTo(widthAdapterBack(38));
        if (self.leftView) {
            make.left.equalTo(self.leftView.mas_right).offset(widthAdapterBack(4));
        }else{
            make.left.equalTo(self.mas_left).offset(marginLeft);
        }
        
        if (self.rightView) {
            make.right.equalTo(self.rightView.mas_left).offset(-widthAdapterBack(4));
        }else{
            make.right.equalTo(self.mas_right).offset(-marginLeft);
        }
    }];
    
    if (styleShowModel.isShowLine) {
        _lineView=[[UIView alloc]initWithFrame:CGRectZero];
        [_lineView setBackgroundColor:[UIColor lineColorOfDefault]];
        [self addSubview:_lineView];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
            make.height.mas_equalTo(1);
            make.left.equalTo(self.mas_left).offset(marginLeft);
        }];
    }
}



-(void)textFieldDidChange:(UITextField *)textField{
    
    if ([textField.text isContainEmoji] || [textField.text hasEmoji]) {
        textField.text = [textField.text filterByRemoveEmoji];
    }
    
    if(styleShowModel.maxWordLength){
        [textField limitCharacterNumberByLength:(int)styleShowModel.maxWordLength];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(styleTextField:didChangedTextInTime:)]) {
        [_delegate styleTextField:self didChangedTextInTime:textField.text];
    }
}

#pragma mark -UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
//    [textField nextResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (_delegate && [_delegate respondsToSelector:@selector(styleTextField:editState:)]) {
        [_delegate styleTextField:self editState:YES];
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([textField.text isContainEmoji] || [textField.text hasEmoji]) {
        textField.text = [textField.text filterByRemoveEmoji];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(styleTextField:editState:)]) {
        [_delegate styleTextField:self editState:NO];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(styleTextField:editInfo:)]) {
        [_delegate styleTextField:self editInfo:C_StringUseful(textField.text)];
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (self.validyRegular) {
        return self.validyRegular(self,string);
    }

    
    if ([textField.text isContainEmoji] || [textField.text hasEmoji]) {
        textField.text = [textField.text filterByRemoveEmoji];
    }
    

    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}





@end
