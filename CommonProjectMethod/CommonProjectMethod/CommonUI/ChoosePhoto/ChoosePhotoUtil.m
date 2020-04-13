//
//  ChoosePhotoUtil.m
//  MIMA
//
//  Created by 陈梦悦 on 2019/7/9.
//  Copyright © 2019 王亮. All rights reserved.
//

#import "ChoosePhotoUtil.h"
#import <UIKit/UIKit.h>
#import "CmyAlertActionSheet.h"
#import "AppPermissionManager.h"

#import "CommonProjectDefines.h"
#import "UIColor+HexColor.h"
#import "UIImage+Addition.h"

@interface ChoosePhotoUtil ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    ChooseShowStyle chooseShowType;
}
@property (nonatomic,strong)UIImagePickerController *imagePickerController;
@property (nonatomic,strong)UIViewController *showPickImgViewCtr;

@property(nonatomic,assign)BOOL isCameraImg;
@property(nonatomic)id pickPhotoCtr;

@end
@implementation ChoosePhotoUtil


-(instancetype)initWithShowView:(UIViewController *)showViewCtr{
    return [self initWithShowView:showViewCtr showStyle:ChoosePhotoTypeDefinedActionSheet];
}


-(instancetype)initWithShowView:(UIViewController *)showViewCtr showStyle:(ChooseShowStyle)showStyle{
    self=[super init];
    if (self) {
        _showPickImgViewCtr=showViewCtr;
        chooseShowType=showStyle;

        switch (showStyle) {
            case ChoosePhotoTypeDefinedActionSheet:
            case ChoosePhotoTypeNativeAlert:
            case  ChoosePhotoTypeDefinedAlert:
            {
                CmyAlertActionSheet *pickImgAlertCtr=[CmyAlertActionSheet alertControllerWithTitle:@"" message:@""];
                CmyAlertAction *photoCamera=[CmyAlertAction actionWithTitle:@"拍摄"  style:CmyAlertActionStyleDefault handler:^(CmyAlertAction * _Nonnull action) {
                    [[AppPermissionManager sharedGlobalAppPermissions]checkThePermissionByType:permissionType_Camera actionBlock:^{
                        [self gotoSelectedPhotoByAlume:NO];
                    }];
                }];
                
                CmyAlertAction *photoAlume=[CmyAlertAction actionWithTitle:@"从本地选取"  style:CmyAlertActionStyleDestructive handler:^(CmyAlertAction * _Nonnull action) {
                    [[AppPermissionManager sharedGlobalAppPermissions]checkThePermissionByType:permissionType_Album actionBlock:^{
                        [self gotoSelectedPhotoByAlume:YES];
                    }];
                }];
                
                CmyAlertAction *cancelAction=[CmyAlertAction actionWithTitle:@"取消"  style:CmyAlertActionStyleCancel handler:^(CmyAlertAction * _Nonnull action) {
                }];
                
                [pickImgAlertCtr addAction:photoCamera];
                [pickImgAlertCtr addAction:photoAlume];
                [pickImgAlertCtr addAction:cancelAction];
                
                _pickPhotoCtr=pickImgAlertCtr;
                
            }
                break;
                case ChoosePhotoTypeNativeActionSheet:
            {
              UIAlertController  *pickImgAlertCtr=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                
                UIAlertAction *photoCamera=[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [[AppPermissionManager sharedGlobalAppPermissions]checkThePermissionByType:permissionType_Camera actionBlock:^{
                        [self gotoSelectedPhotoByAlume:NO];
                    }];
                    
                }];
                
                UIAlertAction *photoAlume=[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    [[AppPermissionManager sharedGlobalAppPermissions]checkThePermissionByType:permissionType_Album actionBlock:^{
                        [self gotoSelectedPhotoByAlume:YES];
                    }];
                    
                }];
                
                UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                
                [pickImgAlertCtr addAction:photoCamera];
                [pickImgAlertCtr addAction:photoAlume];
                [pickImgAlertCtr addAction:cancelAction];
                
                _pickPhotoCtr=pickImgAlertCtr;
                
                //        [photoCamera setValue:[UIColor colorOfFontMiddle_Common] forKey:@"_titleTextColor"];
                //        [photoAlume setValue:[UIColor colorWithHex:0xCE1126] forKey:@"_titleTextColor"];
                //        [cancelAction setValue:[UIColor colorOfFontMiddle_Common] forKey:@"_titleTextColor"];
                //
                //        NSLog(@"ctr;getAllProperty%@ \n getAllIvar:%@",[self getAllProperty:_pickImgAlertCtr],[self getAllIvar:_pickImgAlertCtr]);
                //        NSLog(@"action;getAllProperty%@ \n getAllIvar:%@",[self getAllProperty:photoAlume],[self getAllIvar:photoAlume]);
                
            }
                
                break;
            default:
                break;
        }
        
    }
    return self;
}

-(void)setCanEdit:(BOOL)canEdit{
    _canEdit=canEdit;
    _imagePickerController.allowsEditing =_canEdit;


}

-(void)showPicker:(nullable UIView *)sender{
    switch (chooseShowType) {
        case ChoosePhotoTypeNativeActionSheet:
        {
            
            UIAlertController *pickPhotos=(UIAlertController *)_pickPhotoCtr;
            if (!pickPhotos) {
                return;
            }
            if (!C_DEVICE_IS_IPHONE) {
                if (!sender) {
                    NSLog(@"未传递显示的位置信息");
                    
                    return;
                }
                UIPopoverPresentationController *popPresenter = [pickPhotos popoverPresentationController];
                popPresenter.sourceView = (UIView *)sender;
                popPresenter.sourceRect =((UIView *)sender).bounds;
                [self.showPickImgViewCtr presentViewController:pickPhotos animated:YES completion:nil];
                
                return;
            }
            [self.showPickImgViewCtr presentViewController:pickPhotos animated:YES completion:^{
                
            }];
        }
            break;
        case ChoosePhotoTypeDefinedActionSheet:
        {
            CmyAlertActionSheet *pickPhotos=(CmyAlertActionSheet *)_pickPhotoCtr;
            if (sender) {
                [pickPhotos showCmyAlertController:sender];
            }else{
                [pickPhotos showCmyAlertController:[UIApplication sharedApplication].keyWindow];
            }
        }
            break;
        default:
            break;
    }
}

-(UIImagePickerController *)imagePickerController{
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageWithColor:[UIColor whiteColor]]];
        _imagePickerController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:C_DEVICE_IS_IPHONE?18:20]};
        _imagePickerController.navigationBar.tintColor = [UIColor whiteColor];
        [_imagePickerController.navigationBar setTranslucent:NO];
        _imagePickerController.delegate = self;
    }
    return _imagePickerController;
}


-(void)gotoSelectedPhotoByAlume:(BOOL)isAlume{
  
    self.imagePickerController.allowsEditing =_canEdit;

    if (isAlume) {
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]) {
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;            // 从相册中选取
        }
        _isCameraImg=NO;
        self.imagePickerController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
    }else{
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;            // 拍照
        }
        _isCameraImg=YES;
        
    }
    [_showPickImgViewCtr presentViewController:_imagePickerController
                                      animated:YES
                                    completion:^(void){
                                    }];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}




-(void)gotoEditPicture:(UIImage *)originImg imageName:(NSString *)imageName{
    NSLog(@"跳转到编辑图片的地方，暂留，待补充");
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoOnSelectedSingleImageInfo:)]) {
        [_delegate photoOnSelectedSingleImageInfo:@{UIImagePickerControllerOriginalImage:originImg,UIImagePickedNamed:imageName}];
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoOnSelectedSingleImage:chooseType:)]) {
        [self.delegate photoOnSelectedSingleImage:originImg chooseType:_isCameraImg?ChoosePhotoTypeCamera:ChoosePhotoTypeAlbum];
    }else if (self.delegate && [self.delegate respondsToSelector:@selector(photoOnSelectedSingleImage: imageName:)]) {
        [self.delegate photoOnSelectedSingleImage:originImg imageName:imageName];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^() {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            NSArray *a =[((NSURL *)[info objectForKey:@"UIImagePickerControllerImageURL"]).absoluteString componentsSeparatedByString:@"/"];
            if (C_DEVICE_IS_IPHONE || picker.sourceType==UIImagePickerControllerSourceTypeCamera ) {
                image = [info objectForKey:!self.canEdit?UIImagePickerControllerOriginalImage:UIImagePickerControllerEditedImage];
            }
            if (self.canEdit) {
                [self gotoEditPicture:image imageName:a.lastObject];
            }else{
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(photoOnSelectedSingleImageInfo:)]) {
                    [self.delegate photoOnSelectedSingleImageInfo:@{UIImagePickerControllerOriginalImage:image,UIImagePickedNamed:a.lastObject}];
                    return;
                }
                if (self.delegate && [self.delegate respondsToSelector:@selector(photoOnSelectedSingleImage:chooseType:)]) {
                    [self.delegate photoOnSelectedSingleImage:image chooseType:self.isCameraImg?ChoosePhotoTypeCamera:ChoosePhotoTypeAlbum];
                }else  if (self.delegate && [self.delegate respondsToSelector:@selector(photoOnSelectedSingleImage: imageName:)]) {
                    [self.delegate photoOnSelectedSingleImage:image imageName:a.lastObject];
                }
            }
        });
        //        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }];
    
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^() {
        //        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }];
}



@end
