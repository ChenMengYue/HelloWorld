//
//  UITableView+CmyReload.m
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/8.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//

#import "UITableView+CmyReload.h"
#import <objc/runtime.h>

#import "Masonry.h"
#import "CommonProjectDefines.h"
@interface UITableView ()
@property(nonatomic,strong)UIView *noDataCustomView;
@property(nonatomic,strong)UIView *noDataDefaultView;

@property(nonatomic,strong)UILabel *noDataDefaultLable;
@property(nonatomic,strong)UIImageView *noDataDefaultImgV;
@end

@implementation UITableView (CmyReload)

+(void)load{
    //  只交换一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method reloadData    = class_getInstanceMethod(self, @selector(reloadData));
        Method cmy_reloadData = class_getInstanceMethod(self, @selector(cmy_reloadData));
        method_exchangeImplementations(reloadData, cmy_reloadData);
    });
    
}

-(void)cmy_reloadData{
    [self cmy_reloadData];
    if (![self isShowNoData]) {
//        self.backgroundView=nil;
        [self setBackgroundView:nil];
        return;
    }
    //显示背景
    if (self.nodataDelegate && [self.nodataDelegate respondsToSelector:@selector(tableViewOfNoDataCustomView:)]) {
        
        if ([self isStaticNoData] && !self.noDataCustomView) {
            self.noDataCustomView=[self.nodataDelegate tableViewOfNoDataCustomView:self];
        }else if (!self.noDataCustomView){
            self.noDataCustomView=[self.nodataDelegate tableViewOfNoDataCustomView:self];
        }
        self.noDataSourceView=self.noDataCustomView;
        return;
    }
    
    if (![self isStaticNoData]) {
        [self.noDataDefaultImgV setImage:[self nodataTipImage]];
        self.noDataDefaultLable.text=[self nodataTips];
    }
    [self.noDataDefaultView setHidden:NO];
    [self.noDataDefaultView removeFromSuperview];
    self.noDataSourceView=self.noDataDefaultView;
}

-(UIView *)getBackNoDataWholeView{
    UIView *tmpBgView=[[UIView alloc]initWithFrame:self.frame];
    [tmpBgView setHidden:YES];
    [self addSubview:tmpBgView];
    BOOL isShowImg=NO;
    BOOL isShowTitle=C_StringIsEffective([self nodataTips]);

    if ([self nodataTipImage]) {
        isShowImg=YES;
        [tmpBgView addSubview:self.noDataDefaultImgV];
        [self.noDataDefaultImgV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(tmpBgView);
            if (!isShowTitle) {
                make.center.equalTo(tmpBgView);
            }else{
                make.centerX.equalTo(tmpBgView);
                make.centerY.equalTo(tmpBgView).offset(-20-C_Height_Phone_Home_Indicator);
            }
        }];
    }
    if ([self nodataTips]) {
        [tmpBgView addSubview:self.noDataDefaultLable];
        [self.noDataDefaultLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(tmpBgView);
            make.left.equalTo(tmpBgView).offset(16);

            if (isShowImg) {
                make.top.equalTo(self.noDataDefaultImgV.mas_bottom);
            }else{
                make.centerY.equalTo(tmpBgView);
            }
        }];
    }
    return tmpBgView;
}


#pragma mark -私有方法
-(BOOL)isShowNoData{
    if (self.nodataDelegate && [self.nodataDelegate respondsToSelector:@selector(tableViewOfNoDataViewHiddenState:)]) {
        return ![self.nodataDelegate tableViewOfNoDataViewHiddenState:self];
    }
    return NO;
    
}


-(BOOL)isStaticNoData{
    if (self.nodataDelegate && [self.nodataDelegate respondsToSelector:@selector(tableViewOfNoDataViewIsStatic:)]) {
        return [self.nodataDelegate tableViewOfNoDataViewIsStatic:self];
    }
    return YES;
}

-(NSString *)nodataTips{
    if (self.nodataDelegate && [self.nodataDelegate respondsToSelector:@selector(tableViewOfNoDataMessage:)]) {
        return [self.nodataDelegate tableViewOfNoDataMessage:self];
    }
    return @"暂无数据";
}

-(UIImage *)nodataTipImage{
    if (self.nodataDelegate && [self.nodataDelegate respondsToSelector:@selector(tableViewOfNoDataImage:)]) {
        return [self.nodataDelegate tableViewOfNoDataImage:self];
    }
    return nil;
//    return [UIImage imageNamed:@"courseImage"];
}


-(UIView *)noDataDefaultView{
    if (!objc_getAssociatedObject (self ,_cmd)) {
        self.noDataDefaultView=[self getBackNoDataWholeView];
    }
    return objc_getAssociatedObject (self ,_cmd);
}

-(void)setNoDataDefaultView:(UIView *)noDataDefaultView{
    objc_setAssociatedObject (self , @selector(noDataDefaultView), noDataDefaultView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

-(void)setNoDataCustomView:(UIView *)noDataCustomView{
    objc_setAssociatedObject(self, @selector(noDataCustomView), noDataCustomView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)noDataCustomView{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setNoDataDefaultImgV:(UIImageView *)noDataDefaultImgV{
    objc_setAssociatedObject (self , @selector(noDataDefaultImgV), noDataDefaultImgV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(UIImageView *)noDataDefaultImgV{
    if (!objc_getAssociatedObject (self ,_cmd)) {
        UIImageView *imgTips=[[UIImageView alloc]initWithFrame:CGRectZero];
        if ([self nodataTipImage]) {
            [imgTips setImage:[self nodataTipImage]];
        }
        self.noDataDefaultImgV=imgTips;
    }
    return objc_getAssociatedObject (self ,_cmd);
}

-(void)setNoDataDefaultLable:(UILabel *)noDataDefaultLable{
    objc_setAssociatedObject (self , @selector(noDataDefaultLable), noDataDefaultLable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UILabel *)noDataDefaultLable{
    if (!objc_getAssociatedObject (self ,_cmd)) {
        UILabel *lalTips=[[UILabel alloc]initWithFrame:CGRectZero];
        lalTips.textAlignment=NSTextAlignmentCenter;
//        lalTips.font=FONTSIZE_COMMON;
        lalTips.numberOfLines=0;
//        lalTips.textColor=[UIColor fontColorOfMainGrayStyle];
        lalTips.text=[self nodataTips];
        self.noDataDefaultLable=lalTips;
    }
    return objc_getAssociatedObject (self ,_cmd);
    
}
#pragma mark -私有方法


#pragma mark -公开方法 begin

-(UIView *)noDataSourceView{
    return objc_getAssociatedObject(self, _cmd);

}

-(void)setNoDataSourceView:(UIView *)noDataSourceView{
    objc_setAssociatedObject(self, @selector(noDataSourceView), noDataSourceView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.backgroundView=noDataSourceView?noDataSourceView:nil;
}


-(void)setNodataDelegate:(id<UITableViewNoDataShowsDelegate>)nodataDelegate{
    objc_setAssociatedObject(self, @selector(nodataDelegate), nodataDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

-(id<UITableViewNoDataShowsDelegate>)nodataDelegate{
    return objc_getAssociatedObject(self, _cmd);

}


//-(void)setIsShowNoData:(int)isShowNoData{
//    objc_setAssociatedObject(self, @selector(isShowNoData), @(isShowNoData), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//
//}
//
//-(int)isShowNoData{
//    return [objc_getAssociatedObject(self, _cmd) boolValue];
//}

#pragma mark -公开方法  end

@end



@implementation UITableView(Adapter)

-(void)adapterLater11{
    
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.estimatedRowHeight=0;
        self.estimatedSectionFooterHeight=0;
        self.estimatedSectionHeaderHeight=0;
    } else {
        // Fallback on earlier versions
        
        //        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}


-(void)zeroSeparatorMargin{
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        self.layoutMargins = UIEdgeInsetsZero;
    }
    if([self respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)])
    {
        self.cellLayoutMarginsFollowReadableWidth = NO;
    }
    
    if ([self respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)]) {
        if (@available(iOS 9.0, *)) {
            self.cellLayoutMarginsFollowReadableWidth=NO;
        } else {
            // Fallback on earlier versions
        }
    }
}

@end
