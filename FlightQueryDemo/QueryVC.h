//
//  QueryVC.h
//  FlightQueryDemo
//
//  Created by HongPu on 2015/11/18.
//  Copyright © 2015年 HongPu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FlightQueryDirection)
{
    // 单程
    FlightQueryDirectionOneWay = 0,
    // 往返
    FlightQueryDirectionRoundWay,
};

@interface QueryVC : UIViewController

@end
