//
//  NSDictionary+C_Utils.h
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/8.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (C_Utils)

/*获取Json数据*/
-(NSData *)convertToJsonData;
/*获取Json字符串*/
-(NSString *)getJsonString;
/*字符转转字典*/
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end

NS_ASSUME_NONNULL_END
