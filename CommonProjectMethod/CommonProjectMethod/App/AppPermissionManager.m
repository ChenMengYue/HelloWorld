//
//  AppPermissionManager.m
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/7.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//

#import "AppPermissionManager.h"

#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

#ifdef NSFoundationVersionNumber_iOS_8_x_Max
#import <ContactsUI/ContactsUI.h>
#endif
#import <AddressBookUI/ABPersonViewController.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/ABPeoplePickerNavigationController.h>


static AppPermissionManager *instance;

@implementation AppPermissionManager

+ (instancetype)sharedGlobalAppPermissions
{
    static dispatch_once_t  once;
    dispatch_once(&once, ^{
        instance = [[AppPermissionManager alloc] init];
    });
    return instance;
}

/// 新增API,获取录音权限. 返回值,YES为无拒绝,NO为拒绝录音.
+ (BOOL)isCanRecord
{
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0) {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    bCanRecord = YES;
                } else {
                    bCanRecord = NO;
                }
            }];
        }
    }
    return bCanRecord;
}


+ (void)openContactServiceWithBlock:(permissionCheckIsOpen)permissionBackBlock
{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0

//    if ([[UIDevice currentDevice].systemVersion floatValue ] >= 9.0 ) {
    
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        switch (status) {
            case CNAuthorizationStatusAuthorized:
            {
                if (permissionBackBlock) {
                    permissionBackBlock(YES);
                }
            }
                break;
            case CNAuthorizationStatusDenied:
            case CNAuthorizationStatusRestricted:
            {
                if (permissionBackBlock)
                {
                    permissionBackBlock(NO);
                }
            }
                break;
            case CNAuthorizationStatusNotDetermined:
            {
                CNContactStore *store = [[CNContactStore alloc] init];
                [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError*  _Nullable error) {
                    if (permissionBackBlock) {
                        permissionBackBlock(error?NO:YES);
                    }
                }];

            }
                break;
            default:
                break;
        }
  
    

#else
//    } else {
    
    switch (ABAddressBookGetAuthorizationStatus()) {
        case kABAuthorizationStatusAuthorized:
        {
            if (permissionBackBlock)
            {
                permissionBackBlock(YES);
            }
            
        }
            break;
        case kABAuthorizationStatusDenied:
        case kABAuthorizationStatusRestricted:
        {
            if (permissionBackBlock)
            {
                permissionBackBlock(NO);
            }
        }
            break;
        case kABAuthorizationStatusNotDetermined:
        {
            
        }
            break;
            
        default:
            break;
    }
        
#endif
//    }
    
}



+ (void)openAlbumServiceWithBlock:(permissionCheckIsOpen)permissionBackBlock
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    
    if (authStatus==PHAuthorizationStatusNotDetermined) {
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                switch (status) {
                    case PHAuthorizationStatusAuthorized: //已获取权限
                    {
                        if (permissionBackBlock) {
                            permissionBackBlock(YES);
                        }
                        
                    }
                        break;
                        
                    case PHAuthorizationStatusDenied: //用户已经明确否认了这一照片数据的应用程序访问
                    case PHAuthorizationStatusRestricted://此应用程序没有被授权访问的照片数据。可能是家长控制权限
                    {
                        if (permissionBackBlock) {
                            permissionBackBlock(NO);
                        }
                        
                    }
                        break;
                        
                    default://其他。。。
                        break;
                }
            });
        }];
        return;
    }
    
    if (authStatus == PHAuthorizationStatusRestricted || authStatus == PHAuthorizationStatusDenied ) {
        permissionBackBlock(NO);
        return;
    }
    
    
#else
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied) {
        permissionBackBlock(NO);
        return;
        
        
    }
#endif
    permissionBackBlock(YES);
    
    
}

+ (void)openCaptureDeviceServiceWithBlock:(permissionCheckIsOpen)permissionBackBlock
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (permissionBackBlock) {
                permissionBackBlock(granted);
            }
        }];
    } else if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        permissionBackBlock(NO);
    } else {
        permissionBackBlock(YES);
    }
#endif
}


-(void)checkThePermissionIsOpenByType:(permissionType)typeOfPermission result:(permissionCheckIsOpen)resultIsOpen{
    
    switch (typeOfPermission) {
        case permissionType_Contacts:
        {
            [[self class]openContactServiceWithBlock:^(BOOL isOpen) {
                if (resultIsOpen) {
                    resultIsOpen(isOpen);
                }
            }];
        }
            break;
        case permissionType_Album:
        {
            [[self class] openAlbumServiceWithBlock:^(BOOL isOpen) {
                if (resultIsOpen) {
                    resultIsOpen(isOpen);
                }
            }];
        }
            break;
        case permissionType_Camera:
        {
            [[self class] openCaptureDeviceServiceWithBlock:^(BOOL isOpen) {
                if (resultIsOpen) {
                    resultIsOpen(isOpen);
                }
            }];
        }
            break;
        case permissionType_Record:
        {
            if (resultIsOpen) {
                resultIsOpen([[self class] isCanRecord]);
            }
        }
            break;
        default:
            break;
    }
    
}

-(void)checkThePermissionByType:(permissionType)typeOfPermission actionBlock:(permissionCheckBlock)permissionBlock
{
    [self checkThePermissionByType:typeOfPermission isGotoSetting:YES actionBlock:permissionBlock];
}

-(void)checkThePermissionByType:(permissionType)typeOfPermission isGotoSetting:(BOOL)isSetting actionBlock:(permissionCheckBlock)permissionBlock{
    [self checkThePermissionIsOpenByType:typeOfPermission result:^(BOOL isOpen) {
        if (isOpen) {
            permissionBlock();
            return ;
        }
        if (!isSetting) {
//            ShowDefaultErrorView(@"您还未打开权限，请到设置中打开权限", nil);
            return;
        }
        [self systemPermissionSettingByType:typeOfPermission cancel:^{
            
        } certainSetting:^{
            
        }];
        
    }];
    
}

-(void)systemPermissionSettingByType:(permissionType)typeOfPermission cancel:(void(^)(void))cancelBlock certainSetting:(void(^)(void))certainBlock{
    
    NSString *tips=@"";
    switch (typeOfPermission) {
        case permissionType_Album:
        {
            tips=@"请在设备的“设置-隐私-照片”中允许访问照片";
        }
            break;
        case permissionType_Camera:
        {
            tips=@"请在设备的“设置-隐私-相机”中允许访问相机";
        }
            break;
        case permissionType_Record:{
            tips=@"请在设备的“设置-隐私-相机”中允许访问麦克风";
            
        }
            break;
        case permissionType_Contacts:
        {
            tips=@"请在iPhone的“设置-隐私-通讯录”中允许访问通讯录";
        }
            break;
        default:
            break;
    }
    
//    [UIAlertView bk_showAlertViewWithTitle:@"提示" message:tips cancelButtonTitle:@"取消" otherButtonTitles:@[@"去设置"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
//        if (alertView.cancelButtonIndex!=buttonIndex) {


            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@NO} completionHandler:^(BOOL success) {
                    certainBlock();
                }];
            } else {
                [[UIApplication sharedApplication] openURL:url];
                certainBlock();

            }
//            return ;
//        }
//        cancelBlock();
//    }];
}

@end
