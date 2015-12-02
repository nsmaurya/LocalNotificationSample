//
//  ViewController.m
//  LocalNotificationSample
//
//  Created by Sunil Maurya on 12/2/15.
//  Copyright © 2015 Affle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UITableView *tableV;
    NSMutableArray *arrAllLocalNotification;
}
- (IBAction)btnRefreshClick:(id)sender;
- (IBAction)btnStartNotiClick:(id)sender;
@end

@implementation ViewController
//MARK:- View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    tableV.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    arrAllLocalNotification = [[NSMutableArray alloc] init];
    [arrAllLocalNotification addObjectsFromArray:[[UIApplication sharedApplication] scheduledLocalNotifications]];
    [tableV reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//MARK:- Button Action Event
- (IBAction)btnRefreshClick:(id)sender {
    [arrAllLocalNotification removeAllObjects];
    [arrAllLocalNotification addObjectsFromArray:[[UIApplication sharedApplication] scheduledLocalNotifications]];
    [tableV reloadData];
}

- (IBAction)btnStartNotiClick:(id)sender {
    NSLog(@"startLocalNotification");
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:7];//after 7 second
    notification.alertBody = @"This is local notification!";
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.applicationIconBadgeNumber = 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

//MARK:- TableView DataSource & Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(arrAllLocalNotification.count)
        return arrAllLocalNotification.count;
    else
        return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifier = @"Cell";
   UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    if(arrAllLocalNotification.count){
        UILocalNotification *localNotification = [arrAllLocalNotification objectAtIndex:indexPath.row];
        // Display notification info
        [cell.textLabel setText:localNotification.alertBody];
        [cell.detailTextLabel setText:[localNotification.fireDate description]];
    }
    else
        [cell.textLabel setText:@"No Local Notification Found"];
    return cell;
}
@end
