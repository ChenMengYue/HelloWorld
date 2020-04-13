//
//  SingleMenuPopControl.h
//  PointPenOfKunMing
//
//  Created by 陈梦悦 on 2018/4/12.
//  Copyright © 2018年 陈梦悦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SingleMenuPopControl : NSObject


+ (SingleMenuPopControl *) shareManager;

+(NSArray *)arrayConvertToOnlyTitleMenu:(NSArray *)dataSource;

//数据结构：@[@[title,image,selectedimage],@[title,image,selectedimage],...]
+(NSArray *)arrayConvertToMenu:(NSArray *)dataSource;

+(NSArray *)arrayConvertToMenuByTitle:(NSArray *)titleDataSource image:(NSArray *)imgDataSouce selectedImg:(NSArray *)selectedImgDS;

//datasource :MenuOfPopModel 数组
- (void) showPopMenuSelecteWithOriginY:(float)originY
                            dataSource:(NSArray *)dataSource
                            menuAction:(void (^)(NSInteger selectedIndex))menuAction;
- (void) hideMenu;

- (void) showPopMenuSelecteWithOrigin:(CGPoint)origin
                               inView:(UIView *)view
                           dataSource:(NSArray *)dataSource
                           menuAction:(void (^)(NSInteger selectedIndex))menuAction;

@end
