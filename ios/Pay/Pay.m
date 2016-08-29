//
//  Pay.m
//  Pay
//
//  Created by lichenglong on 16/8/29.
//  Copyright © 2016年 lichenglong. All rights reserved.
//

#import "Pay.h"

#import <AlipaySDK/AlipaySDK.h>
#import "Alipay.h"

@implementation Pay

RCT_EXPORT_MODULE(Pay);

//抛出支付接口
RCT_EXPORT_METHOD(switchPayMethod:(NSString *)prePayInfo methodCode:(NSString *)methodCode resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    //支付宝支付
    [Alipay switchPayMethod:prePayInfo methodCode:methodCode resolver:resolve rejecter:reject];
}

//处理支付宝支付回调
+ (BOOL)parseAlipayURL:(NSURL *)url{
    
    [Alipay alipayParse:url];
    
    return YES;
}

//RCT_REMAP_METHOD(pay, payInfo:(NSString *)payInfo resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
//{
//
//    NSArray *urls = [[NSBundle mainBundle] infoDictionary][@"CFBundleURLTypes"];
//    NSMutableString *appScheme = [NSMutableString string];
//    BOOL multiUrls = [urls count] > 1;
//    for (NSDictionary *url in urls) {
//        NSArray *schemes = url[@"CFBundleURLSchemes"];
//        if (!multiUrls ||
//            (multiUrls && [@"Alipay" isEqualToString:url[@"CFBundleURLName"]])) {
//            [appScheme appendString:schemes[0]];
//            break;
//        }
//    }
//
//    if ([appScheme isEqualToString:@""]) {
//        NSString *error = @"scheme cannot be empty";
//        reject(@"10000", error, [NSError errorWithDomain:error code:10000 userInfo:NULL]);
//        return;
//    }
//
//    _resolve = resolve;
//    _reject = reject;
//
//
//    [[AlipaySDK defaultService] payOrder:(NSString *)payInfo fromScheme:appScheme callback:^(NSDictionary *resultDic){
//        [Alipay alipayResult:resultDic];
//    }];
//}

@end






