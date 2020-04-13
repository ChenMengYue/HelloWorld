//
//  PGBStyleTextFieldViewModel.h
//  PaiGongBao
//
//  Created by 陈梦悦 on 2019/8/1.
//  Copyright © 2019 cmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PGBStyleTextFieldViewType) {
    PGBStyleTextFieldViewTypeNone,
    PGBStyleTextFieldViewTypeIcon,
    PGBStyleTextFieldViewTypeTitle,
    PGBStyleTextFieldViewTypeSendCode
};


@class PGBStyleTextFieldContainerView;
typedef void(^pgbTextFModelViewRefreshFrame)(PGBStyleTextFieldContainerView *modelView,UIView *containView);


#pragma mark -PGBStyleTextFieldViewModel
@interface PGBStyleTextFieldViewModel : NSObject

@property(nonatomic,assign,readonly)PGBStyleTextFieldViewType viewType;
@property(nonatomic,assign,readonly)NSInteger sendCodeType;
@property(nonatomic,copy,readonly)NSString *typeAttribute;

@property(nonatomic,copy)pgbTextFModelViewRefreshFrame refreshFrameBlock;



-(instancetype)initWithType:(PGBStyleTextFieldViewType)type paramsValue:(NSString *)paramValue;
-(instancetype)initWithType:(PGBStyleTextFieldViewType)type paramsValue:(NSString *)paramValue sendCodeType:(NSInteger)sendType;


//-(instancetype)initWithType:(PGBStyleTextFieldViewType)type icon:(nullable NSString *)icon title:(nullable NSString *)title sendCodeTitle:(nullable NSString *)sendCodeTitle sendCodeType:(SendCodeType)sendType;


@end




#pragma mark -PGBStyleTextFieldShowModel
@interface PGBStyleTextFieldShowModel :NSObject

@property(nullable,nonatomic,strong)PGBStyleTextFieldViewModel *txtFLeftViewModel;
@property(nullable,nonatomic,strong)PGBStyleTextFieldViewModel *txtFRightViewModel;

@property(nullable,nonatomic,copy)NSString *placeHolder;

@property(nonatomic,assign)BOOL isShowLine;//默认为YES

@property(nonatomic,assign)NSInteger maxWordLength;//默认50

-(instancetype)initWithoutLineByPlaceHolder:(NSString *)placeHolder maxLength:(NSInteger)maxLength leftParams:(NSString *)leftParams leftType:(PGBStyleTextFieldViewType)leftType;

-(instancetype)initWithPlaceHolder:(NSString *)placeHolder maxLength:(NSInteger)maxLength leftParams:(NSString *)leftParams leftType:(PGBStyleTextFieldViewType)leftType;


@end




NS_ASSUME_NONNULL_END
