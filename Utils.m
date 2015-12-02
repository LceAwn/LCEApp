//
//  Utils.m
//  LCEApp
//
//  Created by juziwl on 15/5/29.
//  Copyright (c) 2015年 juziwl. All rights reserved.
//

#import "Utils.h"

@implementation Utils

/*!
 @brief 空返回YES
 @string string
 */
+ (BOOL)isBlankString:(NSString *)string
{
    if (string == nil || string == NULL)
        return YES;
    
    if ([string isKindOfClass:[NSNull class]])
        return YES;
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
        return YES;
    
    return NO;
}
/*!
 @brief 显示提示内容
 @param msg提示内容
 */
+(void)showMsg:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //alert.tintColor=[self YodoGreen];
    [alert show];
}

/*!
 @brief 显示提示内容
 @param msg提示内容
 */
+(void)showMsg:(NSString *)msg title:(NSString*)title
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    //alert.tintColor=[self YodoGreen];
    [alert show];
}

/*!
 @brief label根据文字改变大小
 @param font 字体大小
 @param maxSize 最大的size
 @param str 文字
 */

+ (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize str:(NSString *)str
{
    CGRect bounds = CGRectZero;
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    bounds = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
    
    bounds.size= CGSizeMake(bounds.size.width,ceilf(bounds.size.height)) ;
    
    return bounds.size;
}
/*!
 @brief label高度
 
 @param font 字体大小
 @param maxSize 最大的size
 @param str 文字
 @param lineSpacing 行间距
 */

+ (NSInteger)heightWithFont:(UIFont* )font width:(CGFloat)width str:(NSString *)str lineSpacing:(CGFloat)lineSpacing{
    
    CGRect bounds = CGRectZero;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing =lineSpacing;
    
    bounds = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesFontLeading| NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle} context:nil];
    
    //    CGSize size = [label.text boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return ceilf(bounds.size.height);
}

/*!
 @brief 设置label行间距
 @param labelText label的文字
 @param LineSpacing 行间距
 */
+(NSMutableAttributedString *)setIntroductionLabelText:(NSString*)labelText setLineSpacing:(CGFloat)LineSpacing
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:LineSpacing];//调整行间距
    //        paragraphStyle.headIndent = 30;//头部缩进，相当于左padding
    //        paragraphStyle.tailIndent = -10;//相当于右padding
    //        paragraphStyle.firstLineHeadIndent = 30;//首行头缩进
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    return attributedString;
}

/*!
 @brief 画水平细线
 @param lineColor 细线颜色 nil:默认0xcccccc
 @param lineWidth 细线宽度b
 */
+(UIImage*)drawHerLine:(UIColor*)lineColor lineWidth:(NSInteger)lineWidth
{
    lineColor=lineColor==nil?UIColorFromRGB(0xcccccc):lineColor;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(lineWidth, 2), NO, 0);
    CGContextRef gc = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(gc, 2);
    [lineColor setStroke];
    CGContextMoveToPoint(gc,0,0);
    CGContextAddLineToPoint(gc, lineWidth, 0);
    //    CGContextAddLineToPoint(gc, lineWidth, 1);
    //    CGContextAddLineToPoint(gc, 0, 1);
    CGContextClosePath(gc);
    CGContextStrokePath(gc);
    UIImage *lineImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return lineImg;
}

/*!
 @brief 画垂直细线
 @param lineColor 细线颜色 nil:默认0xcccccc
 @param lineWidth 细线高度
 */
+(UIImage*)drawVerLine:(UIColor*)lineColor lineHeight:(NSInteger)lineHeight
{
    lineColor=lineColor==nil?UIColorFromRGB(0xcccccc):lineColor;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(10, lineHeight), NO, 0);
    CGContextRef gc = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(gc, 10);
    [lineColor setStroke];
    CGContextMoveToPoint(gc,0,0);
    CGContextAddLineToPoint(gc, 0, lineHeight);
    CGContextClosePath(gc);
    CGContextStrokePath(gc);
    UIImage *lineImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return lineImg;
}
+(NSString *)setStr:(NSString *)startTime endTime:(NSString *)endTime
{
    NSString*string = [startTime substringToIndex:10];//截取下标10之前的字符串
    NSString*string1 = [endTime substringToIndex:10];//截取下标10之前的字符串
    
    string=[string stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    string1=[string1 stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    return [NSString stringWithFormat:@"%@-%@",string,string1];
}

/*!
 @brief 简单绘制线性渐变效果 从上至下
 @param topColor 上色
 @param buttomColor 下色
 */
+(CALayer*)drawLineGradient:(UIColor*)topColor
                buttomColor:(UIColor*)buttomColor
                      frame:(CGRect)frame
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.colors = [NSArray arrayWithObjects:(id)topColor.CGColor,
                       (id)buttomColor.CGColor,nil];
    // 起始点
    gradient.startPoint = CGPointMake(0.5, 0.0);
    
    // 结束点
    gradient.endPoint   = CGPointMake(0.5, 1);
    gradient.frame = frame;
    return gradient;
}

/*!
 @brief 抖动提示
 */
+(void)errorShaked:(UIView*)shakedView delegate:(id)delegate
{
    shakedView.layer.transform=CATransform3DIdentity;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    CATransform3D tr0 = CATransform3DMakeTranslation(0, 0, 0); //CATransform3DMakeScale(0.9, 0.9, 1);
    CATransform3D tr1 = CATransform3DMakeTranslation(10, 0, 0); //CATransform3DMakeScale(0.9, 0.9, 1);
    CATransform3D tr2 = CATransform3DMakeTranslation(-10, 0, 0);
    CATransform3D tr3 = CATransform3DMakeTranslation(0, 0, 0);
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:tr0],
                            [NSValue valueWithCATransform3D:tr1],
                            [NSValue valueWithCATransform3D:tr2],
                            [NSValue valueWithCATransform3D:tr3],
                            nil];
    [animation setValues:frameValues];
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 0.18;
    animation.repeatCount=4;
    animation.delegate=delegate;
    [shakedView.layer addAnimation:animation forKey:@"ShakedAnimation"];
}
/**
 *  放大缩放
 *
 */
+(void)makeScale:(UIView*)scaleView delegate:(id)delegate scale:(CGFloat)scale
{
    
    scaleView.layer.transform=CATransform3DIdentity;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    CATransform3D tr0 = CATransform3DMakeScale(1, 1, 1);
    CATransform3D tr1 = CATransform3DMakeScale(scale, scale, 1);
    CATransform3D tr2 = CATransform3DMakeScale(1, 1, 1);
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:tr0],
                            [NSValue valueWithCATransform3D:tr1],
                            [NSValue valueWithCATransform3D:tr2],
                            nil];
    [animation setValues:frameValues];
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 0.25;
    animation.delegate=delegate;
    [scaleView.layer addAnimation:animation forKey:@"ShakedAnimation"];
}



/*!
 @brief 带Block的弹出框提示
 */
static const char continueBlockkey;
static const char cancelBlockkey;
+(void)confrimMsg:(NSString *)msg continueBlock:(continueBlock)continueBlock
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    objc_removeAssociatedObjects(alertView);
    alertView.delegate=self;
    objc_setAssociatedObject(alertView, &continueBlockkey, continueBlock, OBJC_ASSOCIATION_COPY);
    [alertView show];
}

+(void)confrimMsg:(NSString *)msg
    continueBlock:(continueBlock)continueBlock
      cancelBlock:(continueBlock)cancelBlock
          noTitle:(NSString*)noTitle
         yesTitle:(NSString*)yesTitle
            title:(NSString*)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:noTitle otherButtonTitles:yesTitle, nil];
    objc_removeAssociatedObjects(alertView);
    alertView.delegate=self;
    objc_setAssociatedObject(alertView, &continueBlockkey, continueBlock, OBJC_ASSOCIATION_COPY);
    objc_setAssociatedObject(alertView, &cancelBlockkey, cancelBlock, OBJC_ASSOCIATION_COPY);
    [alertView show];
}


+(void)confrimMsg:(NSString *)msg
    continueBlock:(continueBlock)continueBlock
      cancelBlock:(continueBlock)cancelBlock
          noTitle:(NSString*)noTitle
         yesTitle:(NSString*)yesTitle
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:noTitle otherButtonTitles:yesTitle, nil];
    objc_removeAssociatedObjects(alertView);
    alertView.delegate=self;
    objc_setAssociatedObject(alertView, &continueBlockkey, continueBlock, OBJC_ASSOCIATION_COPY);
    objc_setAssociatedObject(alertView, &cancelBlockkey, cancelBlock, OBJC_ASSOCIATION_COPY);
    [alertView show];
}

+(void)showBlockMsg:(NSString*)msg continueBlock:(continueBlock)continueBlock
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    objc_removeAssociatedObjects(alertView);
    alertView.delegate=self;
    objc_setAssociatedObject(alertView, &cancelBlockkey, continueBlock, OBJC_ASSOCIATION_COPY);
    [alertView show];
}


+(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        continueBlock  messageString =(continueBlock)objc_getAssociatedObject(alertView, &continueBlockkey);
        if(messageString!=nil)
            messageString();
    }
    else if(buttonIndex==0)
    {
        cancelBlock  cancelString =(cancelBlock)objc_getAssociatedObject(alertView, &cancelBlockkey);
        if(cancelString!=nil)
            cancelString();
    }
}
/*!
 @brief 手机号码验证
 */

+(BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    
    
    
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[0127-9]|8[23478]|47|78)\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186,145,176
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56]|45|76)\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,181,189
     22         */
    NSString * CT = @"^1((33|53|8[019]|77)[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        NSLog(@"%@ isNumbericString: YES", mobileNum);
        return YES;
    }
    else
    {
        NSLog(@"%@ isNumbericString: NO", mobileNum);
        return NO;
    }
}


/**
 *  去掉多余的分割线
 *
 *  @param tableView <#tableView description#>
 */
+ (void)hidenExtraCellLine:(UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

/**
 *  TableViewCell分割线靠最左
 *
 *  @param tableViewCell <#tableViewCell description#>
 */
+ (void)separatorInsetZero:(UITableViewCell*)tableViewCell
{
    if ([tableViewCell respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableViewCell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableViewCell respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableViewCell setLayoutMargins:UIEdgeInsetsZero];
    }
}

/**
 *  TableView分割线靠最左
 *
 *  @param tableViewCell <#tableViewCell description#>
 */
+ (void)tableviewSeparatorInsetZero:(UITableView*)tableView
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
}

/**
 *  计算字符串中字符个数 一个汉字占据两个字符
 *
 *  @param string <#string description#>
 *
 *  @return <#return value description#>
 */
+ (NSUInteger)lenghtWithString:(NSString *)string chineseCharCount:(NSUInteger*)chineseCharCount
{
    NSUInteger len = string.length;
    // 汉字字符集
    NSString * pattern  = @"[\u4e00-\u9fa5]";
    NSError *error=nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    if(error)
    {
        NSLog(@"出错");
    }
    
    
    // 计算中文字符的个数
    NSUInteger numMatch = [regex numberOfMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, len)];
    *chineseCharCount=numMatch;
    
    return len + numMatch;
}

/**
 *  滤镜文件夹，具体的
 *
 *  @param nuber 哪一个文件
 *
 *  @return
 */
+(NSString *)getFilterPath:(int)nuber
{
    NSString *path = [[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"filter"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%d",nuber]];
    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    NSAssert(bo,@"创建目录失败");
    return path;
}
/**
 *  滤镜文件夹
 *
 *  @return return value description
 */
+(NSString *)getFilterPath
{
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"filter"];
    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    NSAssert(bo,@"创建目录失败");
    return path;
}

/**
 *  水印文件夹，具体的
 *
 *  @param nuber 哪一个文件
 *
 *  @return
 */
+(NSString *)getWatermarkPath:(int)nuber
{
    NSString *path = [[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"shuiyin"] stringByAppendingPathComponent:[NSString stringWithFormat:@"%d",nuber]];
    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    NSAssert(bo,@"创建目录失败");
    return path;
}
/**
 *  水印文件夹
 *
 *  @return return value description
 */
+(NSString *)getWatermarkPath
{
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"shuiyin"];
    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    NSAssert(bo,@"创建目录失败");
    return path;
}
/**
 *  zip
 *
 *  @param fileName 路径
 *
 *  @return return value description
 */
+(NSString *)getZipPath:(NSNumber*)fileName
{
    NSString *zipName=[NSString stringWithFormat:@"%d.zip",[fileName intValue]];
    NSString *path = [self getZipPath];
    NSString *result = [path stringByAppendingPathComponent:zipName];
    return result;
}
+(NSString *)getZipPath
{
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"ZIP"];
    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    NSAssert(bo,@"创建目录失败");
    return path;
    
}
/**
 *  下载的图片的排序
 *
 *  @return
 */
+(NSArray *)DownloadNumberFile:(StoreType)type
{
    NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:type?[self getFilterPath]:[self getWatermarkPath] error:nil];
    
    //    NSString *match = @"^[0-9]*$";
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    
    NSComparator predicate = ^(id string1,id string2){
        
        if ([string1 integerValue] > [string2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }else if ([string1 integerValue] < [string2 integerValue]){
            return (NSComparisonResult)NSOrderedAscending;
        }
        else
            return (NSComparisonResult)NSOrderedSame;
    };
    
    NSArray *onlyNumber = [dirContents sortedArrayUsingComparator:predicate];
    return onlyNumber;
}
/**
 *  返回的字典
 *
 *  @return
 */
+(NSMutableDictionary*)chooseDictionaryFile:(StoreType)type
{
    NSMutableDictionary* dic=[[NSMutableDictionary alloc]initWithContentsOfFile:type?[self getDownLoadFilePath]:[self getDownLoadWatermarkPath]];
    return dic;
}
/**
 *  下载之后的路径
 *
 *  @return return value description
 */
+(NSString *)getDownLoadWatermarkPath
{
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/Watermark.plist", NSHomeDirectory()];
    return filePath;
}
+(NSString *)getDownLoadFilePath
{
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/Filter.plist", NSHomeDirectory()];
    return filePath;
}

+(void)removeDownLoadItemAtPaths
{
    NSArray *array=@[[self getDownLoadWatermarkPath],[self getDownLoadFilePath],[self getFilterPath],[self getWatermarkPath],[self getZipPath]];
    for (NSString *filePath in array) {
        
        if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
        {
            NSLog(@"----\n%@删除成功\n----",[filePath isEqualToString:[self getDownLoadWatermarkPath]]?@"水印Plist删除":[filePath isEqualToString:[self getDownLoadFilePath]]?@"滤镜Plist删除":[filePath isEqualToString:[self getFilterPath]]?@"滤镜图片删除":[filePath isEqualToString:[self getWatermarkPath]]?@"水印图片删除":[filePath isEqualToString:[self getZipPath]]?@"ZIP删除":@"出错");
            
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
    }
    //    NSString *filePath = [self getDownLoadFilePath];
}

@end