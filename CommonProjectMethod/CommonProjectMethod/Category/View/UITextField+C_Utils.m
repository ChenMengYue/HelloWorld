//
//  UITextField+C_Utils.m
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/7.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//

#import "UITextField+C_Utils.h"

@implementation UITextField (C_Utils)

-(void)limitCharacterNumberByLength:(NSInteger)maxLength{
    UITextField *tmpField=self;
    NSString *toBeString = tmpField.text;
    UITextRange *selectedRange = [tmpField markedTextRange];
    UITextPosition *position = [tmpField positionFromPosition:selectedRange.start offset:0];
    if (!position){
        if (toBeString.length > maxLength){
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
            tmpField.text = [toBeString substringWithRange:rangeRange];
        }
    }

    
}

@end


@implementation UITextView (C_Utils)

-(void)limitCharacterNumberByLength:(NSInteger)maxLength{
    UITextView *tmpTextV=self;
    NSString *toBeString = tmpTextV.text;
    UITextRange *selectedRange = [tmpTextV markedTextRange];
    UITextPosition *position = [tmpTextV positionFromPosition:selectedRange.start offset:0];
    if (!position){
        if (toBeString.length > maxLength){
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
            tmpTextV.text = [toBeString substringWithRange:rangeRange];
        }
    }
}

@end
