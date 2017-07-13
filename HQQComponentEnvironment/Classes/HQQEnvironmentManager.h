//
//  SHEnvironmentManager.h
//  SmartHealth
//
//  Created by 黄强强 on 2017/7/12.
//  Copyright © 2017年 黄强强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQQEnvironmentManager : NSObject

/**
 调用了show方法后，单只手指在状态栏点击5下就会弹出环境切换页面
 */
+ (void)show;
+ (void)hide;

/**
 <#Description#>

 @param paramters 格式类似 
  @{
      @"测试环境":@"http://www.test.com",
      @"正式环境":@"http://www.product.com",
      @"其他环境":@"http://www.other.com"
   }
 
 @param defaultKey 第一次启动时需要默认的key
 
 @param isProductionEnvironment 如果为YES，则show方法失效，正式发布app时应该为YES
 */
+ (void)startWithEnvironmentDict:(NSDictionary<NSString *, NSString *> *)paramters defaultEnvironmentKey:(NSString *)defaultKey isProductionEnvironment:(BOOL)isProductionEnvironment;


/**
 当前环境的url

 @return <#return value description#>
 */
+ (NSString *)currentEnvironment;

@end
