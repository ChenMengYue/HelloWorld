//
//  ChoosePhotoUtil.h
//  MIMA
//
//  Created by 陈梦悦 on 2019/7/9.
//  Copyright © 2019 王亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, ChoosePhotoType) {
    ChoosePhotoTypeCamera,
    ChoosePhotoTypeAlbum,
};

//根据需要进行补充
typedef NS_ENUM(NSUInteger, ChooseShowStyle) {
    ChoosePhotoTypeNativeActionSheet,
    ChoosePhotoTypeNativeAlert,
    ChoosePhotoTypeDefinedActionSheet,
    ChoosePhotoTypeDefinedAlert,//下面的扩展
};


#define UIImagePickedNamed    @"UIImagePickedNamed"

@protocol ChoosePhotoUtilDelegate <NSObject>

@optional

-(void)photoOnSelectedSingleImageInfo:(NSDictionary *)imageData;

//实现一个方法就可以了
-(void)photoOnSelectedSingleImage:(UIImage *)image imageName:(NSString *)imageName;
-(void)photoOnSelectedSingleImage:(UIImage *)image chooseType:(ChoosePhotoType)chooseType;

@end

//暂时ChoosePhotoTypeNativeActionSheet/ChoosePhotoTypeDefinedActionSheet 有效果，其他2个暂时未做，后续补充，
//按照实际传值，ChoosePhotoTypeNativeAlert/ChoosePhotoTypeDefinedAlert 先按照ChoosePhotoTypeDefinedActionSheet 进行绘制
@interface ChoosePhotoUtil : NSObject

@property(nonatomic,assign)BOOL canEdit;
@property(nonatomic,weak)id<ChoosePhotoUtilDelegate> delegate;
@property(nonatomic)id additionInfo;

//默认样式，后续更改
-(instancetype)initWithShowView:(UIViewController *)showViewCtr;
-(instancetype)initWithShowView:(UIViewController *)showViewCtr showStyle:(ChooseShowStyle)showStyle;
//传值详见方法内
-(void)showPicker:(nullable UIView *)sender;
@end

NS_ASSUME_NONNULL_END
