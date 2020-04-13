//
//  UITextField+C_Utils.h
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/7.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (C_Utils)

-(void)limitCharacterNumberByLength:(NSInteger)maxLength;
@end


@interface UITextView (C_Utils)

-(void)limitCharacterNumberByLength:(NSInteger)maxLength;
@end

NS_ASSUME_NONNULL_END
