//
//  NSDictionary+C_Utils.m
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/8.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//

#import "NSDictionary+C_Utils.h"


@implementation NSDictionary (C_Utils)

-(NSData *)convertToJsonData{
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        NSString *jsonStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error] encoding:NSUTF8StringEncoding];
        jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
        jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\\" withString:@""];
//        NSLog(@"[%@] Post Json params valid: %@", [self class], jsonStr);
        NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        if(error) {
            return nil;
        }
        return data;
    }else {
        return nil;
    }
}

-(NSString *)getJsonString{
      if ([NSJSONSerialization isValidJSONObject:self]) {
            NSError *error = nil;
            NSString *jsonStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error] encoding:NSUTF8StringEncoding];
            jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
            jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\\" withString:@""];
//            NSLog(@"[%@] Post Json params valid: %@", [self class], jsonStr);
          return jsonStr;
        }else {
    //                NSLog(@"[%@]Post Json params is not valid: %@", [self class], requestParams);
            return @"";
        }
}


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
