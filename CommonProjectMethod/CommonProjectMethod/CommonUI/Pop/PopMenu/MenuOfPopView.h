//
//  MenuOfPopView.h
//  PointPenOfKunMing
//
//  Created by 陈梦悦 on 2018/4/12.
//  Copyright © 2018年 陈梦悦. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^menuPopViewDidSelectAtIndexPath)(NSIndexPath *selectIndexP);

@interface MenuOfPopView : UIView

@property (nonatomic, strong) UITableView *menuTableView;

-(instancetype)initWithFrame:(CGRect)frame originY:(float)originY data:(NSMutableArray *)arrayDataSource actions:(menuPopViewDidSelectAtIndexPath)menuAction;

-(instancetype)initWithFrame:(CGRect)frame origin:(CGPoint)origin data:(NSMutableArray *)arrayDataSource actions:(menuPopViewDidSelectAtIndexPath)menuAction;

@end
