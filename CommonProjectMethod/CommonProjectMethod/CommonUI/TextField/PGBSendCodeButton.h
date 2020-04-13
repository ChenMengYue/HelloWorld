//
//  PGBSendCodeButton.h
//  PaiGongBao
//
//  Created by 陈梦悦 on 2019/7/31.
//  Copyright © 2019 cmy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SendCodeButtonDelegate <NSObject>

@required
-(NSString *)mobilePhoneBySendCode;

-(void)onCertainSendCode:(NSInteger)codeType mobilePhone:(NSString *)mobilePhone;

-(void)onSendCodeErrorOfNeedInputMobile;
-(void)onSendCodeErrorOfMobileFormatter;
-(void)onSendCodeErrorOfMobileUnAvaiable;


@end


@interface PGBSendCodeButton : UIButton

@property(nonatomic,weak)id<SendCodeButtonDelegate> delegate;
@property(nonatomic,copy)NSString *normalTitle;
@property(nonatomic,assign)NSInteger codeType;

@end

NS_ASSUME_NONNULL_END
