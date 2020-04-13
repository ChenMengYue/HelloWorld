//
//  CommonHeader.h
//  CommonProjectMethod
//
//  Created by upplus_Cmy on 2020/4/7.
//  Copyright © 2020 upplus_Cmy. All rights reserved.
//

#ifndef CommonHeader_h
#define CommonHeader_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#include <CoreGraphics/CGGeometry.h>







//log
#pragma mark - log
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif //.


////全部打印
//#ifdef DEBUG
//
//#define NSLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
//#else
//
//#define NSLog(format, ...)
//
//#endif


#endif /* CommonHeader_h */
