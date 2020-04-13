//
//  NSDateFormatter+C_Util.m
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/13.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//

#import "NSDateFormatter+C_Util.h"


@implementation NSDateFormatter (C_Util)

+ (id)dateFormatter
{
    return [[self alloc] init];
}

+ (id)dateFormatterWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (id)defaultDateFormatter
{
    return [self dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

@end
