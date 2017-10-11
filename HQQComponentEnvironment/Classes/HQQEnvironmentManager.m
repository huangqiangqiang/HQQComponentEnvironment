//
//  SHEnvironmentManager.m
//  SmartHealth
//
//  Created by 黄强强 on 2017/7/12.
//  Copyright © 2017年 黄强强. All rights reserved.
//

#import "HQQEnvironmentManager.h"
#import "HQQEnvironmentViewController.h"
#import <objc/runtime.h>

@implementation HQQEnvironmentManager

static UIWindow *window_;


static char HQQEnvironmentParamterAddress;
static char HQQEnvironmentDefaultKeyAddress;
static char HQQEnvironmentProductionKeyAddress;

+ (void)initialize
{
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
    window_.backgroundColor = [UIColor clearColor];
    window_.windowLevel = UIWindowLevelAlert;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)];
    tap.numberOfTapsRequired = 5;
    [window_ addGestureRecognizer:tap];
}

+ (void)startWithEnvironmentDict:(NSDictionary<NSString *,NSString *> *)paramters defaultEnvironmentKey:(NSString *)defaultKey isProductionEnvironment:(BOOL)isProductionEnvironment
{
    objc_setAssociatedObject(self, &HQQEnvironmentParamterAddress, paramters, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, &HQQEnvironmentDefaultKeyAddress, defaultKey, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, &HQQEnvironmentProductionKeyAddress, @(isProductionEnvironment), OBJC_ASSOCIATION_RETAIN);
}

+ (void)windowClick
{
    NSBundle *bundle = [NSBundle bundleForClass:[HQQEnvironmentManager class]];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"HQQEnvironmentViewController" bundle:bundle];
    HQQEnvironmentViewController *vc = [sb instantiateInitialViewController];
    vc.paramters = objc_getAssociatedObject(self, &HQQEnvironmentParamterAddress);
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}

+ (void)show
{
    if (![objc_getAssociatedObject(self, &HQQEnvironmentProductionKeyAddress) boolValue]) {
        window_.hidden = NO;
    }
}

+ (void)hide
{
    window_.hidden = YES;
}

+ (NSString *)currentEnvironment
{
    NSString *value = [[NSUserDefaults standardUserDefaults] objectForKey:HQQEnvironmentCurrentURLKey];
    if (!value) {
        NSDictionary *dict = objc_getAssociatedObject(self, &HQQEnvironmentParamterAddress);
        NSDictionary *defaultKey = objc_getAssociatedObject(self, &HQQEnvironmentDefaultKeyAddress);
        return dict[defaultKey];
    }
    return value;
}

@end
