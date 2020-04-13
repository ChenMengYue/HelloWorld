//
//  PGBSendCodeButton.m
//  PaiGongBao
//
//  Created by 陈梦悦 on 2019/7/31.
//  Copyright © 2019 cmy. All rights reserved.
//

#import "PGBSendCodeButton.h"
#import "C_MacroOfConstants.h"

@interface PGBSendCodeButton (){
    dispatch_source_t timer_down;
    NSInteger timeDown;
    BOOL isLoaded;
}

@end

@implementation PGBSendCodeButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        timeDown=60;
        
        
        if (!C_StringIsEffective(_normalTitle)) {
            _normalTitle=@"获取验证码";
        }
        self.titleLabel.font=C_FONTSIZE(14, 12);
        [self setTitle:self.normalTitle forState:UIControlStateNormal];
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0x999999]] forState:UIControlStateDisabled];
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor fontColorOfMainBlueStyle]] forState:UIControlStateNormal];
        self.clipsToBounds=YES;
//        self.layer.cornerRadius=4.0f;
        [self addTarget:self action:@selector(onActionOfSendCode:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];

    if (!isLoaded) {
        self.layer.cornerRadius=self.frame.size.height/2;
    }

}


-(void)setNormalTitle:(NSString *)normalTitle{
    _normalTitle=[normalTitle copy];
    [self setTitle:_normalTitle forState:UIControlStateNormal];
}


- (void)countDownFromTime:(NSInteger)startTime
{
    __weak typeof(self) weakSelf = self;
    // 剩余的时间（必须用__block修饰，以便在block中使用）
    __block NSInteger remainTime = startTime;
    // 获取全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    timer_down = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 每隔1s钟执行一次
    dispatch_source_set_timer(timer_down, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    // 在queue中执行event_handler事件
    dispatch_source_set_event_handler(timer_down, ^{
        if (remainTime <= 0) { // 倒计时结束
            dispatch_source_cancel(self->timer_down);
            // 回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf setTitle:@"发送验证码" forState:UIControlStateNormal];
                [self setCodeBtnIsEnable:YES];
            });
        } else {
            NSString *timeStr = [NSString stringWithFormat:@"%ld", remainTime];
            // 回到主线程更新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf setTitle:[NSString stringWithFormat:@"%@秒后重发",timeStr] forState:UIControlStateNormal];
            });
            remainTime--;
        }
    });
    dispatch_resume(timer_down);
}


//停止计时
-(void)stopCountDownFromTime{
    if(timer_down){
        //        __weak typeof(self) weakSelf = self;
        dispatch_source_cancel(timer_down);
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setTitle:self.normalTitle forState:UIControlStateNormal];
            [self setCodeBtnIsEnable:YES];
        });
    }
}

-(BOOL)checkTelPhoneInfo{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(mobilePhoneBySendCode)]) {
        NSString *mobilePhone=[self.delegate mobilePhoneBySendCode];
        if (!C_StringIsEffective(mobilePhone)) {
//            [MBProgressHUD showErrorHUDByInfo:@"请输入手机号"];
            if (_delegate && [_delegate respondsToSelector:@selector(onSendCodeErrorOfNeedInputMobile)]) {
                [_delegate onSendCodeErrorOfNeedInputMobile];
            }

            return NO;
        }
        
//        if (![mobilePhone validateIsMobile]) {
//            ShowDefaultErrorView(@"手机号格式不正确", nil);
//            return NO;
//        }
        return YES;
    }
//    [MBProgressHUD showErrorHUDByInfo:@"未获取到手机号"];
    if (_delegate && [_delegate respondsToSelector:@selector(onSendCodeErrorOfMobileUnAvaiable)]) {
        [_delegate onSendCodeErrorOfMobileUnAvaiable];
    }
    return NO;
    
}


-(void)setCodeBtnIsEnable:(BOOL)codeBtnIsEnable{
    [self setEnabled:codeBtnIsEnable];
    
}


-(void)onActionOfSendCode:(id)sender{
    if (![self checkTelPhoneInfo]) {
        return;
    }
    [self setCodeBtnIsEnable:NO];
    [self countDownFromTime:timeDown];
    if (_delegate  && [_delegate respondsToSelector:@selector(onCertainSendCode: mobilePhone:)]) {
        [_delegate onCertainSendCode:_codeType mobilePhone:[self.delegate mobilePhoneBySendCode]];
    }
}


@end
