//
//  SingleMenuPopControl.m
//  PointPenOfKunMing
//
//  Created by 陈梦悦 on 2018/4/12.
//  Copyright © 2018年 陈梦悦. All rights reserved.
//

#import "SingleMenuPopControl.h"
#import "MenuOfPopView.h"
#import "MenuOfPopTableCell.h"
@interface SingleMenuPopControl ()
@property (nonatomic, strong) MenuOfPopView * popMenuView;
@end


@implementation SingleMenuPopControl

+ (SingleMenuPopControl *) shareManager {
    static SingleMenuPopControl *_PopMenuSingleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _PopMenuSingleton = [[SingleMenuPopControl alloc]init];
    });
    return _PopMenuSingleton;
}

+(NSArray *)arrayConvertToOnlyTitleMenu:(NSArray *)dataSource{
    NSMutableArray *objArr = [NSMutableArray array];
    for (NSInteger i = 0; i < dataSource.count; i++) {
        MenuOfPopModel * info = [MenuOfPopModel new];
        info.title = dataSource[i];
        [objArr addObject:info];
    }
    return objArr;
}

+(NSArray *)arrayConvertToMenu:(NSArray *)dataSource{
    NSMutableArray *objArr = [NSMutableArray array];
    for (NSInteger i = 0; i < dataSource.count; i++) {
        MenuOfPopModel * info = [MenuOfPopModel new];
        if ([dataSource[i] count]>0) {
            info.title = dataSource[i][0];
        }
        if ([dataSource[i] count]>1) {
            info.imageStr = dataSource[i][1];
        }
        if ([dataSource[i] count]>2) {
            info.selectedImgStr = dataSource[i][2];
        }
        [objArr addObject:info];
    }
    return objArr;
}

+(NSArray *)arrayConvertToMenuByTitle:(NSArray *)titleDataSource image:(NSArray *)imgDataSouce selectedImg:(NSArray *)selectedImgDS{
    NSMutableArray *objArr = [NSMutableArray array];
    for (NSInteger i = 0; i < titleDataSource.count; i++) {
        MenuOfPopModel * info = [MenuOfPopModel new];
        info.title = titleDataSource[i];
        if ([imgDataSouce count]>i) {
            info.imageStr = imgDataSouce[i];
        }
        if ([selectedImgDS count]>i) {
            info.selectedImgStr = selectedImgDS[i];
        }
        [objArr addObject:info];
    }
    return objArr;
}

- (void) showPopMenuSelecteWithOriginY:(float)originY
                                dataSource:(NSArray *)dataSource
                              menuAction:(void (^)(NSInteger selectedIndex))menuAction {
    __weak __typeof(&*self)weakSelf = self;
    if (self.popMenuView != nil) {
        [weakSelf hideMenu];
    }
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    self.popMenuView=[[MenuOfPopView alloc]initWithFrame:window.bounds originY:originY data:(NSMutableArray *)dataSource actions:^(NSIndexPath *selectIndexP) {
        menuAction(selectIndexP.row);
        [weakSelf hideMenu];
    }];
    self.popMenuView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
    [window addSubview:self.popMenuView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.popMenuView.menuTableView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
    
    
}

- (void) hideMenu {
    [UIView animateWithDuration:0.15 animations:^{
        self.popMenuView.menuTableView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    } completion:^(BOOL finished) {
        [self.popMenuView.menuTableView removeFromSuperview];
        [self.popMenuView removeFromSuperview];
        self.popMenuView.menuTableView = nil;
        self.popMenuView = nil;
    }];
}


- (void) showPopMenuSelecteWithOrigin:(CGPoint)origin
                               inView:(UIView *)view
                            dataSource:(NSArray *)dataSource
                            menuAction:(void (^)(NSInteger selectedIndex))menuAction {
    __weak __typeof(&*self)weakSelf = self;
    if (self.popMenuView != nil) {
        [weakSelf hideMenu];
    }
    UIWindow * window = [[[UIApplication sharedApplication] windows] firstObject];
    self.popMenuView=[[MenuOfPopView alloc]initWithFrame:window.bounds origin:origin data:(NSMutableArray *)dataSource actions:^(NSIndexPath *selectIndexP) {
        menuAction(selectIndexP.row);
        [weakSelf hideMenu];
    }];
    self.popMenuView.menuTableView.tag=999;
    
    self.popMenuView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
    [window addSubview:self.popMenuView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.popMenuView.menuTableView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];    
}



@end
