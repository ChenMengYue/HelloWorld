//
//  RefreshPagingOfTableView.m
//  lyxCRM
//
//  Created by upplus_Cmy on 2019/10/16.
//  Copyright © 2019 liang yan. All rights reserved.
//

#import "RefreshPagingOfTableView.h"
#import "MJRefresh.h"


@interface RefreshPagingOfTableView ()
@property(nonatomic,assign)int page;
@property(nonatomic,assign)int pageSize;

@property(nonatomic,strong)UITableView *tableView;
@end

@implementation RefreshPagingOfTableView


-(instancetype)init{
    if (self= [super init]) {
        _page=1;
        _pageSize=15;

    }
    return self;
}


-(instancetype)initWithRefreshTable:(UITableView *)tableView{
    self=[self init];
    if (self) {
        _tableView=tableView;
        self.isCanPaging=YES;

    }
    return self;
}

-(void)setIsCanPaging:(BOOL)isCanPaging{
// 马上进入刷新状态
//    [self.tableView.header beginRefreshing];
    _isCanPaging=isCanPaging;
    if (_isCanPaging) {
        __weak RefreshPagingOfTableView *weakSelf=self;
        
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf refreshPagingData];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf loadMoreData];
        }];
    }else{
        [_tableView.mj_header removeFromSuperview];
        [_tableView.mj_footer removeFromSuperview];
    }
}




-(void)refreshPagingData{
    [_tableView.mj_footer resetNoMoreData];
    _page=1;
    if (_delegate && [_delegate respondsToSelector:@selector(refreshPagingDataByType:page:pageSize:refreshPagingView:)]) {
        [_delegate refreshPagingDataByType:RefreshPagingType_Header page:_page pageSize:_pageSize refreshPagingView:self];
    }
}
-(void)loadMoreData{
    _page++;
    
    if (_delegate && [_delegate respondsToSelector:@selector(refreshPagingDataByType:page:pageSize:refreshPagingView:)]) {
        [_delegate refreshPagingDataByType:RefreshPagingType_Footer page:_page pageSize:_pageSize refreshPagingView:self];
    }
}

-(void)successRefreshPagedByType:(RefreshPagingType)refreshType isAllState:(BOOL)isAll{
    [self endRefreshing:refreshType];
      if (isAll) {
          [_tableView.mj_footer endRefreshingWithNoMoreData];
      }
}

-(void)failRefreshPagedByType:(RefreshPagingType)refreshType failedPage:(int)failPage{
    [self endRefreshing:refreshType];
     _page=failPage>1?--failPage:1;
}

-(void)endRefreshing:(RefreshPagingType)refreshType{
    switch (refreshType) {
        case RefreshPagingType_Footer:
        {
            [_tableView.mj_footer endRefreshing];
        }
            break;
        case RefreshPagingType_Header:{
            [_tableView.mj_header endRefreshing];
        }
            break;
        default:
            break;
    }
}





@end
