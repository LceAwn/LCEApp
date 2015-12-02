//
//  Utils.h
//  yodo
//
//  Created by Lance on 14-6-9.
//  Copyright (c) 2014年 jimmy.miao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <objc/objc-runtime.h>

//商店列表类型
typedef enum
{
    WatermarkStore = 0,       //水印商店
    FilterStore = 1,          //滤镜商店
    
}StoreType;

typedef void (^continueBlock)();
typedef void (^cancelBlock)();

@interface Utils : NSObject<UIAlertViewDelegate>

/*!
 @brief 空返回YES
 @string string
 */
+ (BOOL)isBlankString:(NSString *)string;
/*!
 @brief 显示提示内容
 @param msg提示内容
 */
+(void)showMsg:(NSString *)msg;

/*!
 @brief 显示提示内容
 @param msg提示内容
 */
+(void)showMsg:(NSString *)msg title:(NSString*)title;


/*!
 @brief label根据文字改变大小
 @param font 字体大小
 @param maxSize 最大的size
 @param str 文字
 */

+ (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize str:(NSString *)str;

/*!
 @brief label高度
 
 @param font 字体大小
 @param maxSize 最大的size
 @param str 文字
 @param lineSpacing 行间距
 */

+ (NSInteger)heightWithFont:(UIFont* )font width:(CGFloat)width str:(NSString *)str lineSpacing:(CGFloat)lineSpacing;
/*!
 @brief 设置label行间距
 @param labelText label的文字
 @param LineSpacing 行间距
 */
+(NSMutableAttributedString *)setIntroductionLabelText:(NSString*)labelText setLineSpacing:(CGFloat)LineSpacing;
/*!
 @brief 画水平细线
 @param lineColor 细线颜色 nil:默认0xcccccc
 @param lineWidth 细线宽度b
 */
+(UIImage*)drawHerLine:(UIColor*)lineColor lineWidth:(NSInteger)lineWidth;
/*!
 @brief 画垂直细线
 @param lineColor 细线颜色 nil:默认0xcccccc
 @param lineWidth 细线高度
 */
+(UIImage*)drawVerLine:(UIColor*)lineColor lineHeight:(NSInteger)lineHeight;

+(NSString *)setStr:(NSString *)startTime endTime:(NSString *)endTime;

/*!
 @brief 简单绘制线性渐变效果 从上至下
 @param topColor 上色
 @param buttomColor 下色
 */
+(CALayer*)drawLineGradient:(UIColor*)topColor
                buttomColor:(UIColor*)buttomColor
                      frame:(CGRect)frame;

/*!
 @brief 抖动提示
 */
+(void)errorShaked:(UIView*)shakedView delegate:(id)delegate;
/**
 *  放大缩放
 *
 */
+(void)makeScale:(UIView*)scaleView delegate:(id)delegate scale:(CGFloat)scale;

/*!
 @brief 带Block的弹出框提示
 */
+(void)confrimMsg:(NSString *)msg continueBlock:(continueBlock)continueBlock;

+(void)confrimMsg:(NSString *)msg
    continueBlock:(continueBlock)continueBlock
      cancelBlock:(continueBlock)cancelBlock
          noTitle:(NSString*)noTitle
         yesTitle:(NSString*)yesTitle
            title:(NSString*)title;

+(void)confrimMsg:(NSString *)msg
    continueBlock:(continueBlock)continueBlock
      cancelBlock:(continueBlock)cancelBlock
          noTitle:(NSString*)noTitle
         yesTitle:(NSString*)yesTitle;

+(void)showBlockMsg:(NSString*)msg continueBlock:(continueBlock)continueBlock;

+(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
/*!
 @brief 手机号码验证
 */

+(BOOL)validateMobile:(NSString *)mobileNum;


/**
 *  去掉多余的分割线
 *
 *  @param tableView <#tableView description#>
 */
+ (void)hidenExtraCellLine:(UITableView *)tableView;

/**
 *  TableViewCell分割线靠最左
 *
 *  @param tableViewCell <#tableViewCell description#>
 */
+ (void)separatorInsetZero:(UITableViewCell*)tableViewCell;

/**
 *  TableView分割线靠最左
 *
 *  @param tableViewCell <#tableViewCell description#>
 */
+ (void)tableviewSeparatorInsetZero:(UITableView*)tableView;

/**
 *  计算字符串中字符个数 一个汉字占据两个字符
 *
 *  @param string <#string description#>
 *
 *  @return <#return value description#>
 */
+ (NSUInteger)lenghtWithString:(NSString *)string chineseCharCount:(NSUInteger*)chineseCharCount;


+(NSString *)getFilterPath:(int)nuber;


@end
