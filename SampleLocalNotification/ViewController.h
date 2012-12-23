//
//  ViewController.h
//  SampleLocalNotification
//
//  Created by  on 12/02/28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NOTIFICATION_TIME   5   // 現在の日時より何秒後にアラート通知するか

@interface ViewController : UIViewController {
    UILabel *label;
}


/* メソッド */

- (void)localNotificationStart;     // ローカル通知開始
- (void)localNotificationStop;      // ローカル通知停止

@end
