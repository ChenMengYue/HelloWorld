//
//  PopoverListView.m
//  MIMA
//
//  Created by 陈梦悦 on 2019/7/9.
//  Copyright © 2019 王亮. All rights reserved.
//

#import "PopoverListView.h"
#import "PopoverListCell.h"

#import "SinglePopShowManager.h"
#import "Masonry.h"
//#import "UIColor+C_Constants.h"
#import "C_MacroOfConstants.h"


@interface PopoverListView ()<UITableViewDelegate,UITableViewDataSource,SinglePopShowManagerDelegate>
{
    UIView *showView;
    BOOL isLayouted;
    
}
@property(nonatomic,strong)   UIView *bgView;
@property(nonatomic,copy)NSArray *arrayDataSource;
@property(nonatomic,strong)UITableView *popTableV;
@property(nonatomic,strong)UILabel *titleLal;

@property(nonatomic,strong)UIControl   *overlayView;

@property(nonatomic,strong)SinglePopShowManager *managerSingleShow;



@end

@implementation PopoverListView


-(void)dealloc{
    
    
    [self.popTableV removeObserver:self forKeyPath:@"contentOffset"];
    
    

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint offsetValue=[change[NSKeyValueChangeNewKey] CGPointValue];
        
        if (offsetValue.y<0) {
                       [_bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                                 make.height.mas_equalTo(-offsetValue.y+1);
                             }];
             }else if(CGRectGetHeight(_bgView.frame)<1){
                 [_bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                                        make.height.mas_equalTo(1);
                                    }];
             }
      }
    
}


-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView{
    self=[super initWithFrame:frame];
    if (self) {
        showView=superView;
        [self setUpViews];
        [showView addSubview:self];
        [self.popTableV addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];

        //        [showView insertSubview:self aboveSubview:[[showView subviews]lastObject]];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self setUpViews];
        [self.popTableV addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];

    }
    return self;
}

- (void)setUpViews
{
    
    if (showView) {
              _overlayView = [[UIControl alloc] initWithFrame:CGRectZero];//[[UIScreen mainScreen] bounds]
//          _overlayView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.33f];
        _overlayView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.33f];

          [_overlayView addTarget:self
                           action:@selector(dismiss)
                 forControlEvents:UIControlEventTouchUpInside];
          [showView addSubview:_overlayView];
    
      }

    
//    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//    self.layer.borderWidth = 1.0f;
//    self.layer.cornerRadius = 10.0f;
//    self.clipsToBounds = TRUE;
    
    _bgView=[[UIView alloc]initWithFrame:CGRectZero];
    [_bgView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    _titleLal = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLal.font = C_FONTSIZE_COMMON;
    _titleLal.backgroundColor = [UIColor whiteColor];
    _titleLal.textAlignment = NSTextAlignmentCenter;
    _titleLal.textColor = [UIColor fontColorOfMainGrayStyle];
    _titleLal.numberOfLines=0;
    [self addSubview:_titleLal];
    
    _popTableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _popTableV.dataSource = self;
    _popTableV.delegate = self;
    _popTableV.showsVerticalScrollIndicator=NO;
    _popTableV.showsHorizontalScrollIndicator=NO;
    _popTableV.backgroundColor=[UIColor whiteColor];
//    _popTableV.backgroundColor=[UIColor clearColor];
//    [_popTableV setSeparatorColor:[UIColor colorWithHex:0xF4F4F4]];
//    [_popTableV zeroSeparatorMargin];
    [self addSubview:_popTableV];
    

    
    
    [_titleLal setHidden:YES];
    [_titleLal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
    }];
    
    [_popTableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(self.titleLal.mas_bottom);
        make.width.greaterThanOrEqualTo(@100);
    }];

  
}

-(void)setPopoverBgColor:(UIColor *)popoverBgColor{
    _popoverBgColor=popoverBgColor;
    self.popTableV.backgroundColor=_popoverBgColor;
}

-(void)setDelegate:(id<PopoverListViewDelegate>)delegate{
    _delegate=delegate;
    if (_popTableV) {
        [_popTableV reloadData];
    }
}

-(void)updatePopoverData{
    if (_popTableV) {
        [_popTableV reloadData];
//        self.curSelectedIndex=0;
    }
    
//    if (![self.arrayDataSource count] ||_curSelectedIndex>=[self.arrayDataSource count]) {
//        return;
//    }
//    [_popTableV selectRowAtIndexPath:[NSIndexPath indexPathForRow:_curSelectedIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

-(void)setCurSelectedIndex:(NSInteger)curSelectedIndex{
    _curSelectedIndex=curSelectedIndex;
//    if (![self.arrayDataSource count] ||_curSelectedIndex>=[self.arrayDataSource count]) {
//
//
//          return;
//      }
    
    NSInteger showCount=[self tableView:self.popTableV numberOfRowsInSection:0];
    
    if (!showCount ||_curSelectedIndex>=showCount) {
        return;
    }
    
    
    
    
      [_popTableV selectRowAtIndexPath:[NSIndexPath indexPathForRow:_curSelectedIndex inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}


-(void)setTitle:(NSString *)title{
    _title=[title copy];
    if (!C_StringIsEffective(_title)) {
//        _titleLal.hidden=NO;
//        _titleLal.text=_title;
    }
}


#pragma mark - UITableViewDataSource
#pragma mark ---关键修改的地方
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.delegate && [self.delegate respondsToSelector:@selector(popoverListViewData:)]) {
        self.arrayDataSource=[self.delegate popoverListViewData:self];
        
    }else{
        self.arrayDataSource=@[];
    }
    
    NSInteger totalCount=[self.arrayDataSource count];
    if (self.delegate && [self.delegate respondsToSelector:@selector(popoverListViewNumberOfRows:)]) {
        totalCount=[self.delegate popoverListViewNumberOfRows:self];
    }
    
    float cellHeight=widthAdapterBack(44);
    float wholeHeight=0;
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(popoverListView:heightForRowAtIndex:)])
    {
        for (int i=0; i<totalCount; i++) {
            float tmpHeight=[self.delegate popoverListView:self heightForRowAtIndex:i];
            wholeHeight+=tmpHeight;
        }
    }else  if (totalCount>6) {
        wholeHeight=cellHeight*6;
    }else{
        wholeHeight=cellHeight*totalCount;
    }
    [_popTableV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(wholeHeight);
    }];
    return totalCount;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(popoverListView:tableView:cellForIndex:)])
    {
        return [self.delegate popoverListView:self tableView:tableView cellForIndex:indexPath.row];
    }
    
    PopoverListCell *cell=[PopoverListCell cellAllocWithTableView:tableView indexP:indexPath];
    NSString *showInfo=@"";
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(popoverListView:showInfoForIndex:)])
    {
        showInfo=[self.delegate popoverListView:self showInfoForIndex:indexPath.row];
    }
    if (C_StringIsEffective(showInfo)) {
        cell.title=showInfo;
    }else if ([self.arrayDataSource[indexPath.row] isKindOfClass:[NSString class]]) {
        cell.title=self.arrayDataSource[indexPath.row];
    }else{
        cell.title=@"未识别的类型，请添加";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(popoverListView:heightForRowAtIndex:)])
    {
        return [self.delegate popoverListView:self heightForRowAtIndex:indexPath.row];
    }
    
    return widthAdapterBack(44);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _curSelectedIndex=indexPath.row;
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(popoverListView:didSelectInIndex:)])
    {
        [self.delegate popoverListView:self didSelectInIndex:indexPath.row];
    }
    
    [self dismiss];
    
}





#define mark - UITouch
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}

#pragma mark ---关键修改的地方  结束





-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.00001f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    return [BaseTableViewHeaderFooterView headerFooterAllocWithTableView:tableView section:section];
    return nil;
        
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    return [BaseTableViewHeaderFooterView headerFooterAllocWithTableView:tableView section:section];
    return nil;
}

-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    UITableViewHeaderFooterView *footerView=(UITableViewHeaderFooterView *)view;
    footerView.backgroundColor=[UIColor clearColor];
    footerView.contentView.backgroundColor=[UIColor clearColor];
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section{
    UITableViewHeaderFooterView *footerView=(UITableViewHeaderFooterView *)view;
//    footerView.contentView.backgroundColor=[UIColor colorWithHex:0xF4F4F4];
//    footerView.textLabel.textColor=[UIColor colorOfFontLightDefault];
//    footerView.textLabel.font=FontCommonSmall;
    footerView.backgroundColor=[UIColor clearColor];
    footerView.contentView.backgroundColor=[UIColor clearColor];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = NO;
    }
    cell.separatorInset = UIEdgeInsetsZero;
    
}

-(SinglePopShowManager *)managerSingleShow{
    if (!_managerSingleShow) {
        _managerSingleShow=[SinglePopShowManager shareSingleShowManager];
        _managerSingleShow.delegate=self;
    }
    return _managerSingleShow;
}


-(void)showWithOriginY:(float)originY{
    
    if (showView) {
        if (!isLayouted) {
            isLayouted=YES;
            BOOL isScroller=[showView isKindOfClass:[UIScrollView class]];
             [_overlayView mas_remakeConstraints:^(MASConstraintMaker *make) {
                 make.left.right.equalTo(showView);
                 make.top.equalTo(showView.mas_top).offset(originY);
                 make.bottom.equalTo(showView.mas_bottom);
                 if (isScroller) {
                     make.width.equalTo(showView);
                 }
             }];
                 
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(showView);
                make.top.equalTo(showView.mas_top).offset(originY);
            }];
        }
        [_overlayView setHidden:NO];
        [self setHidden:NO];
        return;
    }

    [self.managerSingleShow showPopoverView:self superView:nil showBlock:^(UIView * _Nonnull compareView, UIControl * _Nonnull showBgCtr) {
        showBgCtr.enabled=YES;
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(compareView);
            make.bottom.equalTo(compareView.mas_bottom).offset(widthAdapterBack(10));
        }];
    }];
}



-(void)dismiss{
//        [self fadeOut];
        if (self.delegate&&[self.delegate respondsToSelector:@selector(popoverListViewCancel:)]) {
            [self.delegate popoverListViewCancel:self];
        }
    if (showView) {
        
         [_overlayView setHidden:YES];
         [self setHidden:YES];
        
        return;
    }
    [[SinglePopShowManager shareSingleShowManager] hideShowView];
}

-(void)onSinglePopViewDismissed:(UIView *)showPopView{
    
}





//- (void)fadeIn
//{
//    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
//    self.alpha = 0;
//    [UIView animateWithDuration:.35 animations:^{
//        self.alpha = 1;
//        self.transform = CGAffineTransformMakeScale(1, 1);
//    }];
//
//}
//- (void)fadeOut
//{
//    __weak PopoverListView *weakSelf = self;
//    [UIView animateWithDuration:.35 animations:^{
//        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
//        self.alpha = 0.0;
//    } completion:^(BOOL finished) {
//        if (finished) {
//            [weakSelf.overlayView removeFromSuperview];
//            [self removeFromSuperview];
//        }
//    }];
//}
//

@end
