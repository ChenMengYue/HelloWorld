//
//  Flippedjxb_MyVerticalLable.h
//  FlippedSDK_dev
//
//  Created by 陈梦悦 on 16/11/22.
//  Copyright © 2016年 JacobLi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface MyVerticalLable : UILabel
{
@private
    VerticalAlignment _verticalAlignment;
}
@property (nonatomic) VerticalAlignment verticalAlignment;


@end
