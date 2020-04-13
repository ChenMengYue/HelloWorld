//
//  CmyAlertActionSheet.m
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/8.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//

#import "CmyAlertActionSheet.h"
#import "UIColor+HexColor.h"
#import "Masonry.h"
#import "CommonProjectDefines.h"

@interface CmyAlertAction (){
    
    UIColor *btnNormalColor;
    
    UIColor *colorDefault;
    
}
@property(nonatomic,assign)BOOL isManageredd;
@property(nonatomic,strong)CAShapeLayer *btnLayer;

@property(nonatomic,strong)UIButton *btnTitle;
@property(nonatomic,strong)UIView *bgView;

@property(nonatomic,copy)NSString *title;
@property (nonatomic, copy) void (^handler)(CmyAlertAction *action);

@property(nonatomic,strong)UIView *lineView;
@end

@implementation CmyAlertAction

+(instancetype)actionWithTitle:(NSString *)title style:(CmyAlertActionStyle)style handler:(void (^)(CmyAlertAction * _Nonnull))handler{
    CmyAlertAction *alertAction= [[self alloc] initWithTitle:title style:style handler:handler];
    [alertAction.btnTitle setTitle:title forState:UIControlStateNormal];
    return alertAction;
}

+(instancetype)actionWithTitle:(NSString *)title handler:(void (^)(CmyAlertAction * _Nonnull))handler{
    return [self actionWithTitle:title style:CmyAlertActionStyleDefault handler:handler];
}

- (instancetype)initWithTitle:(NSString *)title style:(CmyAlertActionStyle)style handler:(void (^)(CmyAlertAction *action))handler{
    if ((self = [self initWithFrame:CGRectZero])) {
        _title = [title copy];
        self.style = style;
        _handler = [handler copy];
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        colorDefault = [UIColor colorWithHex:0x101010];
        
        btnNormalColor=colorDefault;
        [self setUpViews];
       
    }
    return self;
}

-(void)setUpViews{
    _btnLayer= [[CAShapeLayer alloc] init];
    _btnLayer.fillColor=[UIColor whiteColor].CGColor;
    
    _bgView=[[UIView alloc]init];
    [self addSubview:_bgView];
    [_bgView.layer addSublayer:_btnLayer];
    
    _lineView=[[UIView alloc]initWithFrame:CGRectZero];
    _lineView.backgroundColor=[UIColor colorWithHex:0xDBDBDB];
    [self addSubview:_lineView];
    
    [_bgView.layer addSublayer:_btnLayer];
    
    _btnTitle=[[UIButton alloc]initWithFrame:CGRectZero];
    
    _btnTitle.titleLabel.font= [UIFont systemFontOfSize: C_DEVICE_IS_IPHONE?14:16];
    
    [_btnTitle addTarget:self action:@selector(onActionOfClick:) forControlEvents:UIControlEventTouchUpInside];
    [_btnTitle addTarget:self action:@selector(OnActionOfShowChanged:) forControlEvents:UIControlEventAllEvents];
    
    [self addSubview:_btnTitle];
    
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(C_SCREEN_WIDTH-30);
        make.height.mas_equalTo(44);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.bgView);
        make.height.mas_equalTo(1);
    }];
    
    [_btnTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.bgView);
        make.top.equalTo(self.lineView.mas_bottom);
    }];
}

-(void)changeHighlightedState:(BOOL)isHigh{
    if (isHigh) {
        //   NSLog(@"changeHighlightedState:YES");

        _btnLayer.fillColor=[UIColor colorWithHex:0xCE1126].CGColor;
        [_btnTitle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        //   NSLog(@"changeHighlightedState:NO");

        _btnLayer.fillColor=[UIColor whiteColor].CGColor;
        [_btnTitle setTitleColor:btnNormalColor forState:UIControlStateNormal];
    }

}

-(void)setStyle:(CmyAlertActionStyle)style{
    _style=style;
    switch (_style) {
        case CmyAlertActionStyleDefault:
        case CmyAlertActionStyleCancel:
        {
            btnNormalColor=colorDefault;
        }
            break;
            
        case CmyAlertActionStyleDestructive:
        {
            
            btnNormalColor=colorDefault;
//            btnNormalColor=[UIColor colorWithHex:0xCE1126];
        }
            break;
        default:
            break;
    }
    [_btnTitle setTitleColor:btnNormalColor forState:UIControlStateNormal];

}


-(void)setPostion:(CmyAlertActionPostion )postion{
    _postion=postion;
    [_lineView setHidden:_postion==CmyAlertActionPostionTop || _postion==CmyAlertActionPostionSingle];

    switch (_postion) {
        case CmyAlertActionPostionTop:
        {
            UIBezierPath *paperPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0,C_SCREEN_WIDTH-30, 44) byRoundingCorners: UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
            [paperPath closePath];
            _btnLayer.path          = paperPath.CGPath;                    // 从贝塞尔曲线获取到形状
        }
            break;
        case CmyAlertActionPostionCenter:
        {
            UIBezierPath *paperPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0,C_SCREEN_WIDTH-30, 44)];
            [paperPath closePath];
            _btnLayer.path          = paperPath.CGPath;                    // 从贝塞尔曲线获取到形状
        }
            break;
        case CmyAlertActionPostionBottom:
        {
            

            UIBezierPath *paperPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0,C_SCREEN_WIDTH-30, 44) byRoundingCorners: UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
            [paperPath closePath];
            _btnLayer.path          = paperPath.CGPath;                    // 从贝塞尔曲线获取到形状

        }
            break;
        case CmyAlertActionPostionSingle:
        {
            UIBezierPath *paperPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0,C_SCREEN_WIDTH-30, 44) byRoundingCorners: UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
            [paperPath closePath];
            _btnLayer.path          = paperPath.CGPath;                    // 从贝塞尔曲线获取到形状
        }
            break;
        default:
            break;
    }

}


-(void)OnActionOfShowChanged:(UIButton *)sender{
    //   NSLog(@"OnActionOfShowChanged:%d",sender.state);
    if (_isManageredd) {
        return;
    }

    [self changeHighlightedState:sender.state==UIControlStateHighlighted];
}

-(void)onActionOfClick:(UIButton *)sender{
    //   NSLog(@"onActionOfClick:%d",sender.state);

    [self changeHighlightedState:sender.state==UIControlStateHighlighted];

    if (self.controlManagerHandler) {
        _isManageredd=YES;
        self.controlManagerHandler(YES,self);
    }
    if (_handler) {
        _handler(self);
    }

}

@end


@interface CmyAlertActionSheet ()
@property(nonatomic,strong)UILabel *lalTitle;
@property(nonatomic,strong)UILabel *lalMessage;

@property (nonatomic, copy) NSArray<CmyAlertAction *> *actions;

@property(nonatomic,strong)CmyAlertAction *cancelAction;

@property(nonatomic,assign)NSInteger cancelButtonIndex;

@property(nonatomic,strong)UIControl *bgCtr;

@end

@implementation CmyAlertActionSheet

+(instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message{
    return [[self alloc] initWithTitle:title message:message];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message{
    if (self=[self initWithFrame:CGRectZero]) {
        _title = [title copy];
        _message = [message copy];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _actions=[NSArray array];
        _bgCtr=[[UIControl alloc]initWithFrame:CGRectZero];
        _bgCtr.backgroundColor=[UIColor colorWithHex:0x000000 alpha:0.45f];
        [_bgCtr addTarget:self action:@selector(onActionofDismiss:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}


-(void)onActionofDismiss:(id)sender{
//    [self dismissCmyAlertController];
}

-(void)dismissCmyAlertController{
    [self removeFromSuperview];
    [_bgCtr removeFromSuperview];
    
}

-(void)showCmyAlertController:(UIView *)showView{
    for (CmyAlertAction *alertAction in self.actions) {
//        [alertAction changeHighlightedState:NO];
        alertAction.isManageredd=NO;
    }
    
    _bgCtr.frame=showView.bounds;
    [showView addSubview:_bgCtr];
    
    [showView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(showView);
    }];
    
//    UIWindow *window=((AppDelegate *)[[UIApplication sharedApplication] delegate]).window;
//    UIWindow *window=[GlobalAppInfo shareAppInfo].rootWindow;
    
    
//    _bgCtr.frame=window.bounds;
//    [window addSubview:_bgCtr];
//
//    [window addSubview:self];
//    [self mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(window);
//    }];
 
}

-(void)setActions:(NSArray<CmyAlertAction *> *)actions{
    _actions=actions;
    NSInteger buttonIndex=0;
    NSMutableArray *arrayEffective=[NSMutableArray array];
    for (CmyAlertAction *alertAction in actions) {
        
        switch (alertAction.style) {
            case CmyAlertActionStyleCancel:
            {
                alertAction.postion=CmyAlertActionPostionSingle;
                [alertAction mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(self);
                    make.bottom.equalTo(self.mas_bottom).offset(-15);
                }];
                alertAction.buttonIndex=[actions count]-1;
            }
                break;
            case CmyAlertActionStyleDestructive:
            case CmyAlertActionStyleDefault:
            {
                alertAction.buttonIndex=buttonIndex;
                [arrayEffective addObject:alertAction];
                buttonIndex++;
            }
                break;
            default:
                break;
        }
        
    }
    
    if (![arrayEffective count]) {
        return;
    }
    
    if ([arrayEffective count]==1) {
        CmyAlertAction *singleAction=[arrayEffective objectAtIndex:0];
        singleAction.postion=CmyAlertActionPostionSingle;
        [singleAction mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.mas_top);
            if (self.cancelAction) {
                make.bottom.equalTo(self.cancelAction.mas_top).offset(-12);
            }else{
                make.bottom.equalTo(self.mas_bottom).offset(-15);
            }
        }];
        return;
    }
    
    CmyAlertAction *compareAction=_cancelAction;
    for (NSInteger i=[arrayEffective count]-1; i>=0; i--) {
        CmyAlertAction *singleAction=[arrayEffective objectAtIndex:i];
        
        if (i==[arrayEffective count]-1) {
            singleAction.postion=CmyAlertActionPostionBottom;
            [singleAction mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                if (self.cancelAction) {
                    make.bottom.equalTo(self.cancelAction.mas_top).offset(-12);
                }else{
                    make.bottom.equalTo(self.mas_bottom).offset(-15);
                }
            }];
            compareAction=singleAction;
            continue;
        }
        
        if (i==0) {
            if (C_StringIsEffective(_title)||C_StringIsEffective(_message)) {
                singleAction.postion=CmyAlertActionPostionCenter;
            }else{
                singleAction.postion=CmyAlertActionPostionTop;
            }
            [singleAction mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.bottom.equalTo(compareAction.mas_top);
                make.top.equalTo(self.mas_top);

            }];
            compareAction=singleAction;
            continue;
        }
        
        singleAction.postion=CmyAlertActionPostionCenter;
        [singleAction mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(compareAction.mas_top);
        }];
        compareAction=singleAction;

    }
    
}

-(void)setTitle:(NSString *)title{
    _title=[title copy];
    if (_lalTitle) {
        _lalTitle.text=_title;
    }
}

-(void)setMessage:(NSString *)message{
    _message=[message copy];
    if (_lalMessage) {
        _lalMessage.text=_message;
    }
}


-(void)addAction:(CmyAlertAction *)action{
    NSAssert([action isKindOfClass:CmyAlertAction.class], @"Must be of type CmyAlertAction");

    action.alertController=self;
    [action changeHighlightedState:NO];

    action.controlManagerHandler = ^(BOOL isRestart, CmyAlertAction * _Nonnull alertAction) {
        //   NSLog(@"controlManagerHandler:%@",alertAction.btnTitle.titleLabel.text);
        [alertAction changeHighlightedState:NO];
        [self dismissCmyAlertController];
    };

    switch (action.style) {
        case CmyAlertActionStyleDestructive:
        {
            
        }
            break;
        case CmyAlertActionStyleCancel:
        {
            if (!_cancelAction) {
                _cancelAction=action;
            }else{
                _cancelAction.style=CmyAlertActionStyleDefault;
                
            }
        }
            break;
        case CmyAlertActionStyleDefault:
        {
            
        }
            break;
        default:
            break;
    }
    [self addSubview:action];
    self.actions = [[NSArray arrayWithArray:self.actions] arrayByAddingObject:action];
    
}

@end

