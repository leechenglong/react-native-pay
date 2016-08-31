//
//  WechatPay.m
//  Pay
//
//  Created by lichenglong on 16/8/31.
//  Copyright © 2016年 lichenglong. All rights reserved.
//

#import "WechatPay.h"


static RCTPromiseResolveBlock _resolve;
static RCTPromiseRejectBlock _reject;

@interface WechatPay ()

@end

@implementation WechatPay

//处理微信支付回调地址
+ (void)wechatParse:(NSURL *)url{

}

//微信支付
+ (void)switchPayMethod:(NSString *)prePayInfo methodCode:(NSString *)methodCode resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject{

    NSLog(@"调用ios微信支付：prePayInfo:%@  ; methodCode: %@", prePayInfo, methodCode);

    NSArray *urls = [[NSBundle mainBundle] infoDictionary][@"CFBundleURLTypes"];
    NSMutableString *appScheme = [NSMutableString string];
    BOOL multiUrls = [urls count] > 1;
    for (NSDictionary *url in urls) {
        NSArray *schemes = url[@"CFBundleURLSchemes"];
        if (!multiUrls ||
            (multiUrls && [@"Wechatpay" isEqualToString:url[@"CFBundleURLName"]])) {
            [appScheme appendString:schemes[0]];
            break;
        }
    }
    
    if ([appScheme isEqualToString:@""]) {
        NSString *error = @"scheme cannot be empty";
        reject(@"10000", error, [NSError errorWithDomain:error code:10000 userInfo:NULL]);
        return;
    }
    
    _resolve = resolve;
    _reject = reject;
}

@end
