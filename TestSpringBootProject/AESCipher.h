//
//  AESCipher.h
//  WLPoetryProject
//
//  Created by 变啦 on 2019/10/30.
//  Copyright © 2019 龙培. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESCipher : NSObject

/**
 *  加密方法，key与iv在AESCipher.m 中配置
 *
 *  @param content 需要加密的内容
 *
 */
+(NSString*)aesEncryptString:(NSString *)content;

/**
 *  解密方法，key与iv在AESCipher.m 中配置
 *
 *  @param content 加密后的内容
 *
 */
+(NSString*)aesDecryptString:(NSString*)content;


/**
 *  加密方法
 *
 *  @param content 需要加密的内容
 *  @param key 加密的key，需要是32位
 *  @param iv 加密的iv
 *
 */
+(NSString *)aesEncryptString:(NSString *)content withKey:(NSString *)key withIv:(NSString*)iv;
/**
 *  解密方法
 *
 *  @param content 加密后的内容
 *  @param key 加密的key，需要是32位
 *  @param iv 加密的iv
 *
 */
+(NSString *)aesDecryptString:(NSString *)content withKey:(NSString *)key withIv:(NSString*)iv;

@end
