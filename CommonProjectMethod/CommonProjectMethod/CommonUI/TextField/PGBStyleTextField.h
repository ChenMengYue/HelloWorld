//
//  PGBStyleTextFieldView.h
//  PaiGongBao
//
//  Created by 陈梦悦 on 2019/7/31.
//  Copyright © 2019 cmy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PGBStyleTextFieldContainerView.h"
//#import "PGBStyleTextFieldViewModel.h"
//@class PGBStyleTextFieldContainerView;


NS_ASSUME_NONNULL_BEGIN



@class PGBStyleTextField;


@protocol PGBStyleTextFieldDelegate <NSObject>
@optional
-(void)styleTextField:(PGBStyleTextField *)textField editInfo:(NSString *)editInfo;

-(void)styleTextField:(PGBStyleTextField *)textField editState:(BOOL)isEdit;

-(void)styleTextField:(PGBStyleTextField *)textField didChangedTextInTime:(NSString *)content;


@end


typedef BOOL (^validyStringIsEffective)(PGBStyleTextField *textField,NSString *string);

@interface PGBStyleTextField : UIView

@property(nonatomic,weak)id<PGBStyleTextFieldDelegate> delegate;


@property(nonatomic,strong,readonly)PGBStyleTextFieldContainerView *leftView;
@property(nonatomic,strong,readonly)PGBStyleTextFieldContainerView *rightView;
@property(nonatomic,strong)UITextField *mainTxtF;

@property(nonatomic,copy)validyStringIsEffective validyRegular;


@property(nonatomic,assign)float widthOfLeftView;



-(instancetype)initWithFrame:(CGRect)frame showModel:(PGBStyleTextFieldShowModel *)showModel;

-(instancetype)initWithFrame:(CGRect)frame showModel:(PGBStyleTextFieldShowModel *)showModel block:(validyStringIsEffective)validyRegular;
/*
 *调用这个方法后，根据相应的左右视图的实际宽度
 *后续有时间了，widthOfLeftView有值的话，做相应的更改
 */
-(void)changeContainerViewShowState:(BOOL)isShow isLeft:(BOOL)isLeft;
@end

NS_ASSUME_NONNULL_END
