//
//  ViewController.m
//  SampleLocalNotification
//
//  Created by  on 12/02/28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // ラベル
    label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 80, 300, 50);
    label.backgroundColor = [UIColor yellowColor];
    label.textAlignment = UITextAlignmentCenter;
    label.numberOfLines = 2;    // 最大行数を2行にする
    [self.view addSubview:label];
    
    // ローカル通知開始ボタン
    UIButton *localNotifStartBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    localNotifStartBtn.frame = CGRectMake(85, 180, 150, 30);
    localNotifStartBtn.tag = 0;  // タグ
    [localNotifStartBtn setTitle:@"ローカル通知開始" forState:UIControlStateNormal];
    [localNotifStartBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:localNotifStartBtn];
    
    // ローカル通知停止ボタン
    UIButton *localNotifStopBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    localNotifStopBtn.frame = CGRectMake(localNotifStartBtn.frame.origin.x, localNotifStartBtn.frame.origin.y + localNotifStartBtn.frame.size.height + 30, localNotifStartBtn.frame.size.width, localNotifStartBtn.frame.size.height);
    localNotifStopBtn.tag = 1;  // タグ
    [localNotifStopBtn setTitle:@"ローカル通知停止" forState:UIControlStateNormal];
    [localNotifStopBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:localNotifStopBtn];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


/* ============================================================================== */
#pragma mark - Button Action
/* ============================================================================== */
- (void)btnAction:(UIButton *)sender
{
    // ローカル通知開始ボタン
    if (sender.tag == 0) {
        [self localNotificationStart];  // ローカル通知を開始
        
        // ラベルへテキストを設定
        label.text = [NSString stringWithFormat:@"ローカル通知を開始しました。\n%d秒後に通知します。", NOTIFICATION_TIME];
    }
    // ローカル通知停止ボタン
    else {
        [self localNotificationStop];   // ローカル通知を停止
        
        // ラベルへテキストを設定
        label.text = @"ローカル通知を停止しました。";
    }
}


/* ============================================================================== */
#pragma mark - UILocalNotification
/* ============================================================================== */
// ローカル通知(アプリが起動していない時、あるいは起動しているがバックグラウンドにある状態の時に「指定時刻になったらユーザーに対して通知する」)
- (void)localNotificationStart
{
    // 現在日時を取得
    NSDate *dateNow = [NSDate date];
    
    // アラート通知する日時
    NSDate *dateAlert =  [dateNow initWithTimeInterval:NOTIFICATION_TIME sinceDate:dateNow]; // 現在日時から5秒後
    
    
    /* ローカル通知設定 */
    
    // ローカル通知を作成する
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    // 通知日時を設定する
    [localNotification setFireDate:dateAlert];
    
    // タイムゾーンを指定する
    [localNotification setTimeZone:[NSTimeZone localTimeZone]];
    
    // 効果音は標準の効果音を利用する
    [localNotification setSoundName:UILocalNotificationDefaultSoundName];
    
    // ボタンの設定
    [localNotification setAlertAction:@"Open"];
    
    // メッセージを設定する
    [localNotification setAlertBody:@"Alert No.1"];
    
    // 特定できるようにキーを設定する
    [localNotification setUserInfo:[NSDictionary  dictionaryWithObject:@"1" forKey:@"NOTIF_KEY"]];
    
    // ローカル通知を登録する
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

// ローカル通知キャンセル
- (void)localNotificationStop
{
    // アラート通知をキャンセルする(重複通知対策)
    for (UILocalNotification *notify in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        NSInteger keyId = [[notify.userInfo objectForKey:@"NOTIF_KEY"] intValue];
        
        if (keyId == 1) {
            [[UIApplication sharedApplication] cancelLocalNotification:notify];
        }
    }
}


@end
