//
//  UIColor+C_Constants.m
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/8.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//

#import "UIColor+C_Constants.h"
#import "UIColor+HexColor.h"



@implementation UIColor (C_Constants)

+(UIColor *)fontColorOfMainBlackStyle{
    return [UIColor colorWithHexString:@"#101010"];
}
+(UIColor *)fontColorOfMainBlueStyle{
    return [UIColor colorWithHexString:@"#408CFF"];
}
+(UIColor *)fontColorOfMainPinkStyle{
    return [UIColor colorWithHexString:@"#FF4081"];
}
+(UIColor *)fontColorOfMainGreenStyle{
    return [UIColor colorWithHexString:@"#259B24"];
}
+(UIColor *)fontColorOfMainRedStyle{
    return [UIColor colorWithHexString:@"#E51C23"];
}
+(UIColor *)fontColorOfMainPurpleStyle{
    return [UIColor colorWithHexString:@"#8E3FB5"];
}
+(UIColor *)fontColorOfMainGrayStyle{
    return [UIColor colorWithHexString:@"#B9BABB"];
}
+(UIColor *)backColorOfMainBackGroundColor{
    return [UIColor colorWithHexString:@"#F8F8F8"];
}
+(UIColor *)lineColorOfDefault{
    return [UIColor colorWithHexString:@"#BBBBBB" alpha:.15];
}

//
+(UIColor *)fontColorOfLightBlueStyle{
    return [UIColor colorWithHexString:@"#4A5064"];
}
//
+(UIColor *)fontColorOfDarkGrayStyle{
    return [UIColor colorWithHexString:@"#434343"];
}
+(UIColor *)backColorOfMainBlue{
    return [UIColor colorWithHexString:@"#408CFF"];
}

+(UIColor *)backColorOfMainOrange{
    return [UIColor colorWithHexString:@"#FF9800"];
}

+(UIColor *)commonOrange{
    return [UIColor colorWithHex:0xFF9800];
}

+(UIColor *)commonMeiRed{
    return [UIColor colorWithHex:0xFF5600];
    
}
@end
