//
//  Alipay.h
//  Alipay
//
//  Created by zmt on 16/8/4.
//  Copyright © 2016年 cn.com.jiuqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTBridgeModule.h"

@interface Alipay : NSObject<RCTBridgeModule>

//处理支付宝支付回调
+ (void)aliPayParse:(NSURL *)url;

@end
