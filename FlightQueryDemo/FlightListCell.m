//
//  FlightListCell.m
//  FlightQueryDemo
//
//  Created by HongPu on 2015/11/19.
//  Copyright © 2015年 HongPu. All rights reserved.
//

#import "FlightListCell.h"
#import "OneWayDirectFlightInfo.h"
#import "OneWayDirectFlightCell.h"

@implementation FlightListCell

+ (instancetype)flightCell:(FlightInfo *)flightInfo withTableView:(UITableView *)tableView
{
    // 判断类型
    if ([flightInfo isKindOfClass:[OneWayDirectFlightInfo class]])
    {
        // 复用ID
        NSString *oneWayDirectFlightInfoIdentify = @"oneWayDirectFlightInfoIdentify";
        
        OneWayDirectFlightCell *cell = (OneWayDirectFlightCell *)[tableView dequeueReusableCellWithIdentifier:oneWayDirectFlightInfoIdentify];
        if (cell)
        {
            return cell;
        }
        else
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OneWayDirectFlightCell" owner:nil options:nil];
            
            if ([nib count] > 0)
            {
                OneWayDirectFlightCell *cell = [nib objectAtIndex:0];
                return cell;
            }
        }
    }
    
    return [[FlightListCell alloc] init];
}

+ (CGFloat)flightCellHeight:(FlightInfo *)flightInfo
{
    static CGFloat cellHeight = 0;
    
    if (cellHeight == 0)
    {
        if ([flightInfo isKindOfClass:[OneWayDirectFlightInfo class]])
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OneWayDirectFlightCell" owner:nil options:nil];
            
            if ([nib count] > 0)
            {
                OneWayDirectFlightCell *cell = [nib objectAtIndex:0];
                cellHeight = cell.frame.size.height;
            }
        }
    }
    
    return cellHeight;

}

- (void)refrushCell:(FlightInfo *)info
{
    NSLog(@"子类必须重写此方法!!!");
    abort();
}

@end
