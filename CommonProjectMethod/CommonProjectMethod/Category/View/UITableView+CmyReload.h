//
//  UITableView+CmyReload.h
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/8.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol UITableViewNoDataShowsDelegate <NSObject>

@required
-(BOOL)tableViewOfNoDataViewHiddenState:(UITableView *)tableView;

@optional
-(BOOL)tableViewOfNoDataViewIsStatic:(UITableView *)tableView;//default is yes
//使用了这个方法，其他方法无效
-(UIView *)tableViewOfNoDataCustomView:(UITableView *)tableView;
//不设置customview的时候的背景图片
-(NSString *)tableViewOfNoDataMessage:(UITableView *)tableView;
//不设置customview的时候的显示的提示
-(UIImage *)tableViewOfNoDataImage:(UITableView *)tableView;
@end

@interface UITableView (CmyReload)
@property(nonatomic,weak)id<UITableViewNoDataShowsDelegate> nodataDelegate;
//@property(nonatomic,assign)int isShowNoData;
@property(nonatomic,strong)UIView *noDataSourceView;
@end


@interface UITableView (Adapter)

-(void)adapterLater11;

-(void)zeroSeparatorMargin;

@end

NS_ASSUME_NONNULL_END
