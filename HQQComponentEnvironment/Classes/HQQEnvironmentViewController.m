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
@property (nonatomic, strong) NSArray *titles;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *appVersion;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *buildVersion;
@property (unsafe_unretained, nonatomic) IBOutlet UISegmentedControl *environmentControl;

@end

@implementation HQQEnvironmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *appVersion =[[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    NSString *build =[[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleVersion"];
    self.appVersion.text = [NSString stringWithFormat:@"%@:%@",@"APP版本",appVersion];
    self.buildVersion.text = [NSString stringWithFormat:@"%@:%@",@"编译版本",build];
    
    [self setupSegmentControl];
}

- (void)setupSegmentControl
{
    // 之前选择的key
    self.titles = self.paramters.allKeys;
    
    // 动态添加segment
    [self.environmentControl removeAllSegments];
    int defIndex = 0;
    for (int i = 0; i < self.titles.count; i++) {
        NSString *key = self.titles[i];
        NSString *value = self.paramters[key];
        [self.environmentControl insertSegmentWithTitle:key atIndex:i animated:NO];
        if ([value isEqualToString:[HQQEnvironmentManager currentEnvironment]]) {
            defIndex = i;
        }
    }
    
    // 选中默认的环境
    self.environmentControl.selectedSegmentIndex = defIndex;
}

- (IBAction)pop {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)switchEnvironment:(UISegmentedControl *)environmentControl {
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
