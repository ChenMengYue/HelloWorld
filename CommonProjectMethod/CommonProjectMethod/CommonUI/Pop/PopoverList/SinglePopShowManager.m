//
//  SinglePopShowManager.m
//  MIMA
//
//  Created by 陈梦悦 on 2019/7/22.
//  Copyright © 2019 王亮. All rights reserved.
//

#import "SinglePopShowManager.h"
#import "Masonry.h"

@interface SinglePopShowManager()
@property(nonatomic,strong)UIView *showedView;

@property(nonatomic,strong)UIControl *ctrBg;

@end

@implementation SinglePopShowManager

+ (SinglePopShowManager *) shareSingleShowManager {
    static SinglePopShowManager *_PopMenuSingleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _PopMenuSingleton = [[SinglePopShowManager alloc]init];
        


    });
    return _PopMenuSingleton;
}

-(instancetype)init{
    self=[super init];
    if (self) {
        //Frame:[[UIScreen mainScreen] bounds]
        UIControl *ctrTmp= [[UIControl alloc] initWithFrame:CGRectZero];
        ctrTmp.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
        [ctrTmp addTarget:self
                   action:@selector(hideShowView)
         forControlEvents:UIControlEventTouchUpInside];
        _ctrBg=ctrTmp;
        
    }
    return self;
}


- (void)hideShowViewWithoutAnimate{
    if (!_showedView) {
        return;
    }
    __weak typeof(self) weakSelf=self;
    [UIView animateWithDuration:0.15 animations:^{
//        weakSelf.showedView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    } completion:^(BOOL finished) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onSinglePopViewDismissed:)]) {
            [weakSelf.delegate onSinglePopViewDismissed:self.showedView];
        }
        [weakSelf.ctrBg removeFromSuperview];
        [weakSelf.showedView removeFromSuperview];
        weakSelf.showedView = nil;
        weakSelf.ctrBg.enabled=YES;
        weakSelf.ctrBg.backgroundColor=[UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
        
    }];
}


- (void) hideShowView {
    if (!_showedView) {
        return;
    }
    __weak typeof(self) weakSelf=self;
    [UIView animateWithDuration:0.15 animations:^{
        weakSelf.showedView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    } completion:^(BOOL finished) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(onSinglePopViewDismissed:)]) {
            [weakSelf.delegate onSinglePopViewDismissed:self.showedView];
        }
        [weakSelf.ctrBg removeFromSuperview];
        [weakSelf.showedView removeFromSuperview];
        weakSelf.showedView = nil;
        weakSelf.ctrBg.enabled=YES;
        weakSelf.ctrBg.backgroundColor=[UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
        
    }];
}



-(void)showPopoverView:(UIView *)showView superView:(nullable UIView *)showSuperView showBlock:(void(^)(UIView *compareView,UIControl *showBgCtr))block{
    __weak typeof(self) weakSelf=self;
    if (self.showedView != nil) {
        [weakSelf hideShowView];
    }
    self.showedView=showView;

    if (!showSuperView) {
        UIWindow * window = [UIApplication sharedApplication].keyWindow;

        
        [window addSubview:self.ctrBg];
        [window addSubview:self.showedView];
        
        [self.ctrBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(window);
        }];
        if (block) {
            block(window,self.ctrBg);
        }
    }else{
        
        [showSuperView addSubview:self.ctrBg];
        [showSuperView addSubview:self.showedView];
        [self.ctrBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(showSuperView);
        }];
        
        if (block) {
            block(showSuperView,self.ctrBg);
        }
        
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.showedView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}

@end
