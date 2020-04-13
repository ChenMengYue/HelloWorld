//
//  AppPermissionManager.h
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/7.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, permissionType) {
    permissionType_Album,
    permissionType_Camera,
    permissionType_Record,//录音
    permissionType_Contacts,
    permissionType_Location,//这个权限还没有写，等待补充
};

typedef void(^permissionCheckIsOpen)(BOOL isOpen);

typedef void(^permissionCheckBlock)(void);


@interface AppPermissionManager : NSObject

+ (instancetype)sharedGlobalAppPermissions;


-(void)checkThePermissionIsOpenByType:(permissionType)typeOfPermission result:(permissionCheckIsOpen)permissionBackBlock;

-(void)systemPermissionSettingByType:(permissionType)typeOfPermission cancel:(void(^)(void))cancelBlock certainSetting:(void(^)(void))certainBlock;

-(void)checkThePermissionByType:(permissionType)typeOfPermission actionBlock:(permissionCheckBlock)permissionBlock;

-(void)checkThePermissionByType:(permissionType)typeOfPermission isGotoSetting:(BOOL)isSetting actionBlock:(permissionCheckBlock)permissionBlock;

@end

NS_ASSUME_NONNULL_END
