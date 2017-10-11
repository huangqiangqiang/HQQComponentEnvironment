//
//  HQQViewController.m
//  HQQComponentEnvironment
//
//  Created by huangqiangqiang on 07/13/2017.
//  Copyright (c) 2017 huangqiangqiang. All rights reserved.
//

#import "HQQViewController.h"
#import <HQQComponentEnvironment/HQQEnvironmentManager.h>

@interface HQQViewController ()

@end

@implementation HQQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSBundle *bundle = [NSBundle bundleForClass:[HQQEnvironmentManager class]];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"HQQEnvironmentViewController" bundle:bundle];
    NSURL *url = [bundle URLForResource:@"HQQEnvironmentViewController" withExtension:@"bundle"];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@",url);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
