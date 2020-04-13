//
//  MenuOfPopView.m
//  PointPenOfKunMing
//
//  Created by 陈梦悦 on 2018/4/12.
//  Copyright © 2018年 陈梦悦. All rights reserved.
//

#import "MenuOfPopView.h"
#import "MenuOfPopTableCell.h"
#import "SingleMenuPopControl.h"
#import "C_MacroOfConstants.h"


@interface MenuOfPopView()<UITableViewDataSource,UITableViewDelegate>
{
    float originTableY;
    float originTableX;
}
@property(nonatomic,strong)NSMutableArray *menuDataSource;
@property (nonatomic, copy) menuPopViewDidSelectAtIndexPath tableViewDidSelectRowAtIndexPath;


@end

@implementation MenuOfPopView

-(instancetype)initWithFrame:(CGRect)frame originY:(float)originY data:(NSMutableArray *)arrayDataSource actions:(menuPopViewDidSelectAtIndexPath)menuAction{
    self=[super initWithFrame:frame];
    if (self) {
        self.menuDataSource=arrayDataSource;
        self.tableViewDidSelectRowAtIndexPath=[menuAction copy];
        originTableY=originY;
        [self addSubview:self.menuTableView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame origin:(CGPoint)origin data:(NSMutableArray *)arrayDataSource actions:(menuPopViewDidSelectAtIndexPath)menuAction
{
    self=[super initWithFrame:frame];
    if (self) {
        self.menuDataSource=arrayDataSource;
        self.tableViewDidSelectRowAtIndexPath=[menuAction copy];
        originTableY=origin.y;
        originTableX = origin.x;
        [self addSubview:self.menuTableView];
    }
    return self;
}

-(NSMutableArray *)menuDataSource{
    if (!_menuDataSource) {
        _menuDataSource=[NSMutableArray array];
    }
    return _menuDataSource;
}



-(UITableView *)menuTableView{
    if (!_menuTableView) {
        
        CGFloat widthOfMenu =adapterWidth(2, 180, 270);

               float heightOfMenu;
        
        if ([self.menuDataSource count]) {
                heightOfMenu=adapterWidth(2, 52, 78)+adapterWidth(2, 44, 66)*([self.menuDataSource count]-1)+adapterWidth(2, 44, 66);
//            heightOfMenu=adapterWidth(2, 52, 78)+adapterWidth(2, 44, 66)*([self.menuDataSource count]-1);

                     }else{
                         heightOfMenu=adapterWidth(2, 52, 78);
                     }
        
               CGFloat x = originTableX ? originTableX : C_SCREEN_WIDTH-adapterWidth(2, 10, 20)-widthOfMenu;
        
        
        _menuTableView = [[UITableView alloc]initWithFrame:CGRectMake(x, originTableY, widthOfMenu, heightOfMenu) style:UITableViewStylePlain];
        [_menuTableView setBackgroundColor:[UIColor clearColor]];
        _menuTableView.dataSource = self;
        _menuTableView.delegate   = self;
        _menuTableView.scrollEnabled=[_menuDataSource count]>6?YES:NO;
        [self addSubview:_menuTableView];
        
        if ([_menuTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_menuTableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_menuTableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_menuTableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return _menuTableView;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuDataSource.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PopMenuOfPosition tmpPosition;
    if([self.menuDataSource count]<2){
        tmpPosition=PopMenuOfPosition_All;
    }else  if (indexPath.row==0) {
        tmpPosition=PopMenuOfPosition_Top;
    }else  if (indexPath.row==[self.menuDataSource count]-1) {
        tmpPosition=PopMenuOfPosition_Bottom;
    }else{
        tmpPosition=PopMenuOfPosition_Common;
    }
    MenuOfPopModel *tmpModel=self.menuDataSource[indexPath.row];
    MenuOfPopTableCell * cell = [MenuOfPopTableCell cellAllocWithMenuTableView:tableView position:tmpPosition];
    [cell reInitMenuPopData:tmpModel];
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return [MenuOfPopTableCell menuPopCellHeight:PopMenuOfPosition_Top];
    }
    if (indexPath.row==[self.menuDataSource count]-1) {
        return [MenuOfPopTableCell menuPopCellHeight:PopMenuOfPosition_Bottom];
    }
    return [MenuOfPopTableCell menuPopCellHeight:PopMenuOfPosition_Common];

}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.tableViewDidSelectRowAtIndexPath) {
        self.tableViewDidSelectRowAtIndexPath(indexPath);
    }
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuOfPopTableCell * cell = (MenuOfPopTableCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setIsShowSelectedState:YES];
}
-(void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuOfPopTableCell * cell = (MenuOfPopTableCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setIsShowSelectedState:NO];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[SingleMenuPopControl shareManager]hideMenu];
}

@end
