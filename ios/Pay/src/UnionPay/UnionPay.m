//
//  UnionPay.m
//  Pay
//
//  Created by lichenglong on 16/8/31.
//  Copyright © 2016年 lichenglong. All rights reserved.
//

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#import "UnionPay.h"
#import "UPPaymentControl.h"

static RCTPromiseResolveBlock _resolve;
static RCTPromiseRejectBlock _reject;

@implementation UnionPay

//Union支付
+ (void)switchPayMethod:(NSString *)prePayInfo methodCode:(NSString *)methodCode resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject{
    
    NSArray *urls = [[NSBundle mainBundle] infoDictionary][@"CFBundleURLTypes"];
    NSMutableString *appScheme = [NSMutableString string];
    BOOL multiUrls = [urls count] > 1;
    for (NSDictionary *url in urls) {
        NSArray *schemes = url[@"CFBundleURLSchemes"];
        if (!multiUrls ||
            (multiUrls && [@"UnionPay" isEqualToString:url[@"CFBundleURLName"]])) {
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
    
    //mode : "00"代表接入生产环境（正式版本需要）；"01"代表接入开发测试环
    [[UPPaymentControl defaultControl] startPay:prePayInfo fromScheme:@"UPPayDemo" mode:@"01" viewController:[[UIApplication sharedApplication] keyWindow].rootViewController];
}

//处理Union支付回调地址
+ (void)unionParse:(NSURL *)url{

    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
        //结果code为成功时，先校验签名，校验成功后做后续处理
        if([code isEqualToString:@"success"]) {
            
            //判断签名数据是否存在
            if(data == nil){
                //如果没有签名数据，建议商户app后台查询交易结果
                return;
            }
            
            //数据从NSDictionary转换为NSString
            NSData *signData = [NSJSONSerialization dataWithJSONObject:data options:0 error:nil];
            NSString *sign = [[NSString alloc] initWithData:signData encoding:NSUTF8StringEncoding];
            
            //验签证书同后台验签证书
            //此处的verify，商户需送去商户后台做验签
            if([self verify:sign]) {
                //支付成功且验签成功，展示支付成功提示
            }
            else {
                //验签失败，交易结果数据被篡改，商户app后台查询交易结果
            }
            
            if(_resolve){
                _resolve(@[data]);
            }
        }
        else if([code isEqualToString:@"fail"]) {
            //交易失败
            if (_reject) {
                _reject(@"交易取消", @"交易取消", [NSError errorWithDomain:@"交易取消" code:-1 userInfo:NULL]);
            }
        }
        else if([code isEqualToString:@"cancel"]) {
            //交易取消
            if (_reject) {
                _reject(@"交易取消", @"交易取消", [NSError errorWithDomain:@"交易取消" code:-1 userInfo:NULL]);
            }
        }
    }];

}

//校验
+ (BOOL)verify:(NSString *)resultStr {
    
    //验签证书同后台验签证书
    //此处的verify，商户需送去商户后台做验签
    return NO;
}



@end
