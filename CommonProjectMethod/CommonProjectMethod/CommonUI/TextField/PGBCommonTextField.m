//
//  PGBCommonTextField.m
//  PaiGongBao
//
//  Created by 陈梦悦 on 2019/7/31.
//  Copyright © 2019 cmy. All rights reserved.
//

#import "PGBCommonTextField.h"

@implementation PGBCommonTextField



-(CGRect)textRectForBounds:(CGRect)bounds{
    CGRect curTextRect=[super textRectForBounds:bounds];
    curTextRect.origin.x=14;
    return curTextRect;
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect curTextRect=[super editingRectForBounds:bounds];
    curTextRect.origin.x=14;
    return curTextRect;
}


@end
