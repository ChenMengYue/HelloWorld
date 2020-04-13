//
//  PopoverListView.h
//  MIMA
//
//  Created by 陈梦悦 on 2019/7/9.
//  Copyright © 2019 王亮. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PopoverListView;

@protocol PopoverListViewDelegate <NSObject>

@required
- (void)popoverListView:(PopoverListView *)popoverListView didSelectInIndex:(NSInteger)selectedIndex;

@optional
//这个方法用了的时候，popoverListViewNumberOfRows 这个不需要实现
//当是字符数组的时候，不需要实现showInfoForIndex
-(NSArray *)popoverListViewData:(PopoverListView *)popoverListView;
//这个方法用的时候，必须组合showInfoForIndex方法来使用
- (NSInteger)popoverListViewNumberOfRows:(PopoverListView *)popoverListView;
//对应的行显示的文本数据，数据源是字符数组的时候可以不用传,传了的话不影响
- (NSString *)popoverListView:(PopoverListView *)popoverListView
             showInfoForIndex:(NSInteger)index;

- (void)popoverListViewCancel:(PopoverListView *)popoverListView;

//定制的cell
- (UITableViewCell *)popoverListView:(PopoverListView *)popoverListView tableView:(UITableView *)tableView
                        cellForIndex:(NSInteger)index;
- (CGFloat)popoverListView:(PopoverListView *)popoverListView
       heightForRowAtIndex:(NSInteger)index;
@end


//高度自适应，给宽度
@interface PopoverListView : UIView
@property (nonatomic, weak) id<PopoverListViewDelegate> delegate;

@property(nonatomic)id additionInfo;//附加字段，类型不固定

@property(nonatomic,copy)NSString *title;//暂时无效，预留

@property(nonatomic,strong)UIColor *popoverBgColor;

/*更新界面数据*/
-(void)updatePopoverData;

@property(nonatomic,assign)NSInteger curSelectedIndex;

/*
 *初始化方法
 *superView：父试图，可空，空的话加载window上
 */
-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView;

/*
*显示方法
*originY：显示的起始位置，相对于父试图而言
*/
-(void)showWithOriginY:(float)originY;


/*
*消失方法方法
*/
-(void)dismiss;

@end

NS_ASSUME_NONNULL_END
