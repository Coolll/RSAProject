//
//  RSAEncryptor.h
//  TestSpringBootProject
//
//  Created by 变啦 on 2019/8/30.
//  Copyright © 2019年 变啦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSAEncryptor : NSObject
/**
 *  加密方法
 *
 *  @param str    需要加密的字符串
 *  @param pubKey 公钥字符串
 */
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;

/**
 *  解密方法
 *
 *  @param str     需要解密的字符串
 *  @param privKey 私钥字符串
 */
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;


//content 原文
//priKey 私钥字符串
+ (NSString *)sign:(NSString *)content withPriKey:(NSString *)priKey;

//content 原文
//signature 加密后的签名
//publicKey 公钥字符串
+ (BOOL)verify:(NSString *)content signature:(NSString *)signature withPublivKey:(NSString *)publicKey;


@end
