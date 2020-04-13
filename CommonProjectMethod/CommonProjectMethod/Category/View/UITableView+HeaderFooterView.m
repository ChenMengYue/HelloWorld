//
//  UITableView+HeaderFooterView.m
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/7.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//

#import "UITableView+HeaderFooterView.h"

@implementation UITableView (HeaderFooterView)

-(void)appendAutoSizeView:(UIView *)view isHeader:(BOOL)isHeader{
    CGFloat height=[view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame=view.bounds;
    frame.size.height=height;
    view.frame=CGRectMake(frame.origin.x, 0, frame.size.width, height);
    if (isHeader) {
        self.tableHeaderView=view;
    }else{
        self.tableFooterView=view;
    }
}

@end
