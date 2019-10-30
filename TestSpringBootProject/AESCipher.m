//
//  AESCipher.m
//  WLPoetryProject
//
//  Created by 变啦 on 2019/10/30.
//  Copyright © 2019 龙培. All rights reserved.
//

#import "AESCipher.h"
#import <CommonCrypto/CommonCryptor.h>
@implementation AESCipher

static NSString *publicKey = @"12345678876543211234567887654321";
static NSString *publicIv = @"8888777766665544";

+(NSString *)aesEncryptString:(NSString *)content{
    return [self aesEncryptString:content withKey:publicKey withIv:publicIv];
}
+(NSString *)aesDecryptString:(NSString *)content{
    return [self aesDecryptString:content withKey:publicKey withIv:publicIv];
}

+(NSString *)aesEncryptString:(NSString *)content withKey:(NSString *)key withIv:(NSString*)iv{
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *ivData = [iv dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encrptData = [self aesEncryptData:contentData withKey:keyData withIv:ivData];
    return [encrptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

+(NSString *)aesDecryptString:(NSString *)content withKey:(NSString *)key withIv:(NSString*)iv {
    NSData *contentData = [[NSData alloc] initWithBase64EncodedString:content options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *ivData = [iv dataUsingEncoding:NSUTF8StringEncoding];
    NSData *decryptedData = [self aesDecryptData:contentData withKey:keyData withIv:ivData];
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}

+(NSData *)aesEncryptData:(NSData *)contentData withKey:(NSData *)keyData withIv:(NSData*)ivData {
    return [self cipherAction:contentData withKey:keyData withIv:ivData withOperation:kCCEncrypt];
}

+(NSData *)aesDecryptData:(NSData *)contentData withKey:(NSData *)keyData withIv:(NSData*)ivData {
    return [self cipherAction:contentData withKey:keyData withIv:ivData withOperation:kCCDecrypt];
}


+(NSData *) cipherAction:(NSData *)contentData withKey:(NSData *)keyData withIv:(NSData*)ivData withOperation:(CCOperation) operation{
    NSUInteger dataLength = contentData.length;
    
    void const *ivBytes = ivData.bytes;
    void const *contentBytes = contentData.bytes;
    void const *keyBytes = keyData.bytes;
    
    size_t bufferSize = dataLength + kCCKeySizeAES256;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          keyBytes,
                                          kCCKeySizeAES256,
                                          ivBytes,
                                          contentBytes,
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}


@end
