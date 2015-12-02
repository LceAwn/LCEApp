//
//  headerFiles.h
//  LCEApp
//
//  Created by juziwl on 15/5/29.
//  Copyright (c) 2015年 juziwl. All rights reserved.
//

#ifndef LCEApp_headerFiles_h
#define LCEApp_headerFiles_h


#define LCEAppDele ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed : ((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green : ((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue : ((float)(rgbValue & 0xFF)) / 255.0 alpha : 1.0]

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


#define IS_NULL_STRING(__POINTER) \
(__POINTER == nil || \
__POINTER == (NSString *)[NSNull null] || \
![__POINTER isKindOfClass:[NSString class]] || \
![__POINTER length])



#endif
