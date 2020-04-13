//
//  RefreshPagingOfTableView.h
//  lyxCRM
//
//  Created by upplus_Cmy on 2019/10/16.
//  Copyright © 2019 liang yan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "RefreshPagingDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface RefreshPagingOfTableView : NSObject

-(instancetype)initWithRefreshTable:(UITableView *)tableView;

@property(nonatomic,weak)id<RefreshPagingDelegate> delegate;

@property(nonatomic,assign)BOOL isCanPaging;//default is YES
//初始化数据用,重新从page=1开始拉数据
-(void)refreshPagingData;

-(void)successRefreshPagedByType:(RefreshPagingType)refreshType isAllState:(BOOL)isAll;

-(void)failRefreshPagedByType:(RefreshPagingType)refreshType failedPage:(int)failPage;

@end

NS_ASSUME_NONNULL_END
