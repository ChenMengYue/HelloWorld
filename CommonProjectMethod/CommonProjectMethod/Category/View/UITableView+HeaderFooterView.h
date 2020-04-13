//
//  UITableView+HeaderFooterView.h
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/7.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (HeaderFooterView)

-(void)appendAutoSizeView:(UIView *)view isHeader:(BOOL)isHeader;

@end

NS_ASSUME_NONNULL_END
