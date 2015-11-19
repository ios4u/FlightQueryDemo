//
//  FlightListCell.h
//  FlightQueryDemo
//
//  Created by HongPu on 2015/11/19.
//  Copyright © 2015年 HongPu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlightInfo;

// 航班列表Cell父类
@interface FlightListCell : UITableViewCell

// 工厂方法根据FlightInfo类型返回不同的Cell
+ (instancetype)flightCell:(FlightInfo *)flightInfo withTableView:(UITableView *)tableView;
// 刷新Cell数据
- (void)refrushCell:(FlightInfo *)info;
// 获取cell高度
+ (CGFloat)flightCellHeight:(FlightInfo *)flightInfo;

@end
