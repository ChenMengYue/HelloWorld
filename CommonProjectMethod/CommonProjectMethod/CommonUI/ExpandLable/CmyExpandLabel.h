//
//  CmyExpandLabel.h
//  kyapp
//
//  Created by 陈梦悦 on 2019/1/1.
//  Copyright © 2019 ypjy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyVerticalLable.h"


NS_ASSUME_NONNULL_BEGIN

@protocol CmyExpandLabelDelegate <NSObject>

-(void)onChangeExpandState:(BOOL)isExpand;
@end

@interface CmyExpandLabel : UIView

@property(nonatomic,weak)id<CmyExpandLabelDelegate> delegate;
//最多多少行显示扩展按钮  default =3
@property(nonatomic,assign)int numOfshowExpand;
//default no
@property(nonatomic,assign)BOOL isShowExpandBtn;

@property(nonatomic,assign)float lineSpace;
@property(nonatomic,assign)float textSpace;

@property(nonatomic,assign)float lalWidth;


//扩展
//default  全部，收起
//如果是其他的话，请更改title 的正常和选中状态
@property(nonatomic,strong)UIButton *btnExpand;
@property(nonatomic,strong)MyVerticalLable *vertaicalLal;

@property(nonatomic,strong)NSString *content;


@end

NS_ASSUME_NONNULL_END
