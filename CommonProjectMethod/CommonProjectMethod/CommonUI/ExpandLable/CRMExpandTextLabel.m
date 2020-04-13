//
//  CRMExpandTextLabel.m
//  lyxCRM
//
//  Created by upplus_Cmy on 2019/11/26.
//  Copyright © 2019 liang yan. All rights reserved.
//

#import "CRMExpandTextLabel.h"
#import "MyVerticalLable.h"
#import "Masonry.h"
#import "C_MacroOfConstants.h"


@interface CRMExpandTextLabel ()
@property(nonatomic,assign)CRMExpandTextType expandType;
@property(nonatomic,strong)MyVerticalLable *vertaicalLal;


@end

@implementation CRMExpandTextLabel

-(instancetype)initWithFrame:(CGRect)frame{
    self=[self initWithFrame:frame type:CRMExpandTextType_Default];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame type:(CRMExpandTextType)expandType{
    self=[super initWithFrame:frame];
    if (self) {
        _expandType=expandType;

        [self setUpViews];
    }
    return self;
}

-(void)setUpViews{
    [self addSubview:self.vertaicalLal];
        [self.vertaicalLal mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.equalTo(self);
     }];
 
}


-(MyVerticalLable *)vertaicalLal{
    if (!_vertaicalLal) {
        _vertaicalLal=[[MyVerticalLable alloc]init];
        _vertaicalLal.verticalAlignment=VerticalAlignmentTop;
        _vertaicalLal.textColor=[UIColor fontColorOfMainGrayStyle];
        _vertaicalLal.font=C_FONTSIZE_SMALL;
        _vertaicalLal.numberOfLines=0;
        [self addSubview:_vertaicalLal];
    }
    return _vertaicalLal;
}


@end
