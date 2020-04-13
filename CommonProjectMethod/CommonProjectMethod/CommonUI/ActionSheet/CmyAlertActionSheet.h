//
//  CmyAlertActionSheet.h
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/8.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CmyAlertActionStyle) {
    CmyAlertActionStyleDefault = 0,
    CmyAlertActionStyleCancel,
    CmyAlertActionStyleDestructive
};

typedef NS_ENUM(NSUInteger, CmyAlertActionPostion) {
    CmyAlertActionPostionDefault,
    CmyAlertActionPostionCenter=CmyAlertActionPostionDefault,
    CmyAlertActionPostionTop,
    CmyAlertActionPostionBottom,
    CmyAlertActionPostionSingle,
};


@class CmyAlertActionSheet;

@interface CmyAlertAction : UIView

+ (instancetype)actionWithTitle:(nullable NSString *)title style:(CmyAlertActionStyle)style handler:(void (^ __nullable)(CmyAlertAction *action))handler;

+ (instancetype)actionWithTitle:(nullable NSString *)title handler:(void (^ __nullable)(CmyAlertAction *action))handler;

@property (nullable, nonatomic, readonly) NSString *title;
@property (nonatomic, assign) CmyAlertActionStyle style;
@property (nonatomic, weak) CmyAlertActionSheet *alertController;
@property(nonatomic,assign)CmyAlertActionPostion postion;

@property(nonatomic,assign)NSInteger buttonIndex;
@property(nonatomic,copy)void(^controlManagerHandler)(BOOL isRestart,CmyAlertAction *alertAction);

-(void)changeHighlightedState:(BOOL)isHigh;
@end


@interface CmyAlertActionSheet : UIView

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message;

- (void)addAction:(CmyAlertAction *)action;

@property (nonatomic, readonly) NSArray<CmyAlertAction *> *actions;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *message;

-(void)showCmyAlertController:(UIView *)showView;
@end

NS_ASSUME_NONNULL_END
