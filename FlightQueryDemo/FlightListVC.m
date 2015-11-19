//
//  FlightListVC.m
//  FlightQueryDemo
//
//  Created by HongPu on 2015/11/19.
//  Copyright © 2015年 HongPu. All rights reserved.
//

#import "FlightListVC.h"
#import "ResultData.h"
#import "FlightListCell.h"

@interface FlightListVC () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation FlightListVC


- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.result.arrayResult count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FlightInfo *info = [self.result.arrayResult objectAtIndex:[indexPath row]];
    return [FlightListCell flightCellHeight:info];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FlightInfo *info = [self.result.arrayResult objectAtIndex:[indexPath row]];
    FlightListCell *cell = [FlightListCell flightCell:info withTableView:tableView];
    [cell refrushCell:info];
    return cell;
}

@end
