//
//  SHEnvironmentViewController.m
//  SmartHealth
//
//  Created by 黄强强 on 2017/7/12.
//  Copyright © 2017年 黄强强. All rights reserved.
//

#import "HQQEnvironmentViewController.h"
#import "HQQEnvironmentManager.h"

NSString *HQQEnvironmentCurrentURLKey = @"HQQEnvironmentCurrentURLKey";

@interface HQQEnvironmentViewController ()

@end

@implementation HQQEnvironmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *back = [[UIButton alloc] init];
    back.frame = CGRectMake(0, 0, 100, 44);
    back.center = self.view.center;
    [back setTitle:@"退出" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:back];
    [back addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 之前选择的key
    NSString *currentValue = [HQQEnvironmentManager currentEnvironment];
    __block NSString *currentKey = nil;
    [self.paramters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isEqualToString:currentValue]) {
            currentKey = key;
            *stop = YES;
        }
    }];
    
    UISegmentedControl *environmentControl = [[UISegmentedControl alloc] initWithItems:self.paramters.allKeys];
    environmentControl.selectedSegmentIndex = [self.paramters.allKeys indexOfObject:currentKey];
    environmentControl.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    [environmentControl addTarget:self action:@selector(switchEnvironment:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:environmentControl];
}

- (void)backClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)switchEnvironment:(UISegmentedControl *)environmentControl
{
    NSString *value = self.paramters[[environmentControl titleForSegmentAtIndex:environmentControl.selectedSegmentIndex]];
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:HQQEnvironmentCurrentURLKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 提示
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"环境切换成功" message:@"需要重启app才生效，点击确定退出app" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
        exit(0);
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
