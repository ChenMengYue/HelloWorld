//
//  RefreshPagingOfCollectionView.m
//  lyxCRM
//
//  Created by upplus_Cmy on 2019/10/18.
//  Copyright © 2019 liang yan. All rights reserved.
//

#import "RefreshPagingOfCollectionView.h"

#import "MJRefresh.h"

@interface RefreshPagingOfCollectionView ()
@property(nonatomic,assign)int page;
@property(nonatomic,assign)int pageSize;

@property(nonatomic,strong)UICollectionView *collectionView;
@end

@implementation RefreshPagingOfCollectionView


-(instancetype)init{
    if (self= [super init]) {
        _page=1;
        _pageSize=15;

    }
    return self;
}


-(instancetype)initWithRefreshCollectionView:(UICollectionView *)collectionView{
    self=[self init];
    if (self) {
        _collectionView=collectionView;
        self.isCanPaging=YES;

    }
    return self;
}

-(void)setIsCanPaging:(BOOL)isCanPaging{
// 马上进入刷新状态
//    [self.tableView.header beginRefreshing];
    _isCanPaging=isCanPaging;
    if (_isCanPaging) {
        __weak RefreshPagingOfCollectionView *weakSelf=self;
        
        _collectionView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf refreshPagingData];
        }];
        _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf loadMoreData];
        }];
    }else{
        [_collectionView.mj_header removeFromSuperview];
        [_collectionView.mj_footer removeFromSuperview];
    }
}




-(void)refreshPagingData{
    [_collectionView.mj_footer resetNoMoreData];
    _page=1;
    if (_delegate && [_delegate respondsToSelector:@selector(refreshPagingDataByType:page:pageSize:refreshPagingView:)]) {
        [_delegate refreshPagingDataByType:RefreshPagingType_Header page:_page pageSize:_pageSize refreshPagingCollectionView:self];
    }
}
-(void)loadMoreData{
    _page++;
    
    if (_delegate && [_delegate respondsToSelector:@selector(refreshPagingDataByType:page:pageSize:refreshPagingView:)]) {
        [_delegate refreshPagingDataByType:RefreshPagingType_Footer page:_page pageSize:_pageSize refreshPagingCollectionView:self];
    }
}

-(void)successRefreshPagedByType:(RefreshPagingType)refreshType isAllState:(BOOL)isAll{
    [self endRefreshing:refreshType];
      if (isAll) {
          [_collectionView.mj_footer endRefreshingWithNoMoreData];
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
            [_collectionView.mj_footer endRefreshing];
        }
            break;
        case RefreshPagingType_Header:{
            [_collectionView.mj_header endRefreshing];
        }
            break;
        default:
            break;
    }
}


@end
