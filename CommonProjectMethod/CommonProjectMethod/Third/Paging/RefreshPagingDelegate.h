//
//  RefreshPagingDelegate.h
//  lyxCRM
//
//  Created by upplus_Cmy on 2019/10/16.
//  Copyright © 2019 liang yan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, RefreshPagingType) {
    RefreshPagingType_None,
    RefreshPagingType_Header,
    RefreshPagingType_Footer,
};


NS_ASSUME_NONNULL_BEGIN

@class RefreshPagingOfTableView ;
@class RefreshPagingOfCollectionView;


@protocol RefreshPagingDelegate <NSObject>

@optional
-(void)refreshPagingDataByType:(RefreshPagingType)refreshType page:(int)page pageSize:(int)pageSize refreshPagingView:(RefreshPagingOfTableView *)refreshPagingView;

-(void)refreshPagingDataByType:(RefreshPagingType)refreshType page:(int)page pageSize:(int)pageSize refreshPagingCollectionView:(RefreshPagingOfCollectionView *)refreshPagingView;


@end

NS_ASSUME_NONNULL_END
