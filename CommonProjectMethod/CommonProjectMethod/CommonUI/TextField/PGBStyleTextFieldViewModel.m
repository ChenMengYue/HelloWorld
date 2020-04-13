//
//  PGBStyleTextFieldViewModel.m
//  PaiGongBao
//
//  Created by 陈梦悦 on 2019/8/1.
//  Copyright © 2019 cmy. All rights reserved.
//

#import "PGBStyleTextFieldViewModel.h"

#pragma mark - PGBStyleTextFieldViewModel
@interface PGBStyleTextFieldViewModel ()
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *sendCodeTitle;
@property(nonatomic,assign)NSInteger sendCodeType;
@property(nonatomic,assign)PGBStyleTextFieldViewType viewType;
@end

@implementation PGBStyleTextFieldViewModel

-(NSString *)typeAttribute{
    switch (_viewType) {
        case PGBStyleTextFieldViewTypeNone:
        {
        }
            break;
        case PGBStyleTextFieldViewTypeIcon:
        {
            return _icon;
        }
            break;
        case PGBStyleTextFieldViewTypeTitle:
        {
            return _title;
        }
            break;
        case PGBStyleTextFieldViewTypeSendCode:
        {
            return _sendCodeTitle;
        }
            break;
        default:
            break;
    }
    return @"";
}

-(instancetype)initWithType:(PGBStyleTextFieldViewType)type icon:(NSString *)icon title:(NSString *)title sendCodeTitle:(NSString *)sendCodeTitle sendCodeType:(NSInteger)sendType{
    self=[super init];
    if (self) {
        _viewType=type;
        switch (_viewType) {
            case PGBStyleTextFieldViewTypeNone:
            {
            }
                break;
            case PGBStyleTextFieldViewTypeIcon:
            {
                _icon=[icon copy];
            }
                break;
            case PGBStyleTextFieldViewTypeTitle:
            {
                _title=[title copy];
            }
                break;
            case PGBStyleTextFieldViewTypeSendCode:
            {
                _sendCodeType=sendType;
                _sendCodeTitle=[sendCodeTitle copy];
            }
                break;
            default:
                break;
        }
    }
    return self;
}
-(instancetype)initWithType:(PGBStyleTextFieldViewType)type paramsValue:(NSString *)paramValue {
    self=[super init];
    if (self) {
        _viewType=type;
        switch (_viewType) {
            case PGBStyleTextFieldViewTypeNone:
            {
            }
                break;
            case PGBStyleTextFieldViewTypeIcon:
            {
                _icon=[paramValue copy];
            }
                break;
            case PGBStyleTextFieldViewTypeTitle:
            {
                _title=[paramValue copy];
            }
                break;
            case PGBStyleTextFieldViewTypeSendCode:
            {
                _sendCodeTitle=[paramValue copy];
            }
                break;
            default:
                break;
        }
    }
    return self;
}

-(instancetype)initWithType:(PGBStyleTextFieldViewType)type paramsValue:(NSString *)paramValue sendCodeType:(NSInteger)sendType{
    self=[self initWithType:type paramsValue:paramValue];
    if (self) {
        if (_viewType==PGBStyleTextFieldViewTypeSendCode) {
            _sendCodeType=sendType;
        }
    }
    return self;
}

@end



#pragma mark -PGBStyleTextFieldShowModel
@implementation PGBStyleTextFieldShowModel

-(instancetype)initWithoutLineByPlaceHolder:(NSString *)placeHolder maxLength:(NSInteger)maxLength leftParams:(NSString *)leftParams leftType:(PGBStyleTextFieldViewType)leftType{
    self=[self initWithPlaceHolder:placeHolder maxLength:maxLength leftParams:leftParams leftType:leftType];
    if (self) {
        _isShowLine=NO;
    }
    return self;
}

-(instancetype)initWithPlaceHolder:(NSString *)placeHolder maxLength:(NSInteger)maxLength leftParams:(NSString *)leftParams leftType:(PGBStyleTextFieldViewType)leftType{
    self=[super init];
    if (self) {
//        _isShowLine=YES;
        _maxWordLength=maxLength;
        self.placeHolder=placeHolder;
        switch (leftType) {
            case PGBStyleTextFieldViewTypeIcon:
            case PGBStyleTextFieldViewTypeTitle:
            {
                self.txtFLeftViewModel=[[PGBStyleTextFieldViewModel alloc]initWithType:leftType paramsValue:leftParams];
            }
                break;
            case PGBStyleTextFieldViewTypeSendCode:
            {
                self.txtFLeftViewModel=[[PGBStyleTextFieldViewModel alloc]initWithType:leftType  paramsValue:leftParams sendCodeType:0];
            }
            default:
                break;
        }
    }
    return self;
}


-(instancetype)init{
    self=[super init];
    if (self) {
        _isShowLine=YES;
        _maxWordLength=50;
    }
    return self;
}
@end
