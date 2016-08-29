//
//  Alipay.h
//  Pay
//
//  Created by lichenglong on 16/8/29.
//  Copyright © 2016年 lichenglong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RCTBridgeModule.h"

@interface Alipay : NSObject

//处理支付宝支付回调地址
+ (void)alipayParse:(NSURL *)url;

//支付宝支付
+ (void)switchPayMethod:(NSString *)prePayInfo methodCode:(NSString *)methodCode resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject;

@end
