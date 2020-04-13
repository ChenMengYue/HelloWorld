//
//  CRMExpandTextLabel.h
//  lyxCRM
//
//  Created by upplus_Cmy on 2019/11/26.
//  Copyright © 2019 liang yan. All rights reserved.
//

#import <UIKit/UIKit.h>

//@import MyVerticalLable;
#import "MyVerticalLable.h"


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CRMExpandTextType) {
    CRMExpandTextType_Default,
    CRMExpandTextType_OnlyAll,
    CRMExpandTextType_OnlySimple,
};

@interface CRMExpandTextLabel : UIView

@property(nonatomic,strong,readonly)MyVerticalLable *vertaicalLal;

-(instancetype)initWithFrame:(CGRect)frame type:(CRMExpandTextType)expandType;


@end

NS_ASSUME_NONNULL_END
