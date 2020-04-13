//
//  MenuOfPopTableCell.h
//  PointPenOfKunMing
//
//  Created by 陈梦悦 on 2018/4/12.
//  Copyright © 2018年 陈梦悦. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PopMenuOfPosition) {
    PopMenuOfPosition_All,//只显示一项的时候用这个
    PopMenuOfPosition_Top,
    PopMenuOfPosition_Common,
    PopMenuOfPosition_Bottom,
};

@interface MenuOfPopModel:NSObject

@property (nonatomic ,strong) NSString * imageStr;
@property (nonatomic,strong)NSString *selectedImgStr;
@property (nonatomic ,strong) NSString * title;
@end


@interface MenuOfPopTableCell : UITableViewCell
@property(nonatomic,assign)BOOL isShowSelectedState;
+ (instancetype) cellAllocWithMenuTableView:(UITableView *)tableView position:(PopMenuOfPosition)position;

-(void)reInitMenuPopData:(MenuOfPopModel *)menuModel;

+(float)menuPopCellHeight:(PopMenuOfPosition)position;

@end
