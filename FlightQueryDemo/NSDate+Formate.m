//
//  NSDate+Formate.m
//  FlightQueryDemo
//
//  Created by HongPu on 2015/11/18.
//  Copyright © 2015年 HongPu. All rights reserved.
//

#import "NSDate+Formate.h"

@implementation NSDate (Formate)

- (NSString *)formateString
{
    if (self == nil)
    {
        return @"";
    }
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    
//    return [NSString stringWithFormat:@"%li-%@-%@", (long)year, (long)month < 10 ? [NSString stringWithFormat:@"0%li", (long)month] : [NSString stringWithFormat:@"%li", (long)month], (long)day < 10 ? [NSString stringWithFormat:@"0%li", (long)day] : [NSString stringWithFormat:@"%li", (long)day]];
    
    return [NSString stringWithFormat:@"%li-%@-%@", (long)year, [NSDate formateNumber:month], [NSDate formateNumber:day]];
}

+ (NSString *)formateNumber:(NSInteger)number
{
    return [NSString stringWithFormat:@"%2ld", (long)number];
}

@end
