//
//  Pay.h
//  Pay
//
//  Created by lichenglong on 16/8/29.
//  Copyright © 2016年 lichenglong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RCTBridgeModule.h"

@interface Pay : NSObject<RCTBridgeModule>

//处理支付宝支付回调
+ (BOOL)parseAlipayURL:(NSURL *)url;

//处理微信支付回调
+ (BOOL)parseWechatPayURL:(NSURL *)url;

//处理Union支付回调
+ (BOOL)parseUnionPayURL:(NSURL *)url;

@end
