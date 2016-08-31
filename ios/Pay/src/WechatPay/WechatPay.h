//
//  WechatPay.h
//  Pay
//
//  Created by lichenglong on 16/8/31.
//  Copyright © 2016年 lichenglong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RCTBridgeModule.h"

@interface WechatPay : NSObject

//微信支付
+ (void)switchPayMethod:(NSString *)prePayInfo methodCode:(NSString *)methodCode resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject;

//处理微信支付回调地址
+ (void)wechatParse:(NSURL *)url;

@end
