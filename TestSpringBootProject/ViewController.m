//
//  ViewController.m
//  TestSpringBootProject
//
//  Created by 变啦 on 2018/12/25.
//  Copyright © 2018年 变啦. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "RSAEncryptor.h"
#import <Foundation/Foundation.h>
@interface ViewController ()
/**
 *
 **/
@property (nonatomic,strong) UILabel *myLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:234/255.f green:234/255.f blue:234/255.f alpha:1.0];


}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self testEncryptAndDecrypt];
    [self testSignAndVerify];
}


- (void)testSignAndVerify{
    NSString *origin = @"1234567890";
    //签名时 私钥需要是pkcs1格式，转换一下才可以使用
    NSString *privateKey = @"MIICXAIBAAKBgQCGCmJL7KLKlk2sHmT5GOlIw9cFqEhwfhTaGqrqDRn1jfCRDh9ppe+mabiCvst6jH5MbCVMVGaqcLyrtzCTAWEsj7GLGvYn0TnpLcxr2w4Df//kGLHpGn8Or90fn4SK+Pku5PX94X2WtA8ospagmcz/+Y0WMoHQl5tRs26bWUXa1QIDAQABAoGAEZbbP0tWMW930dZLOcTjGAFa/gsPNnPVGKnXM890UJzHrMFFrf9wa04EQGP5H6PADxdB7bpFnqgcmgv3+9J6hcWzeA5y4hrB0ESmxbdnTxVft99zO1CA2IG+2OX5h5gKxWeHs2PlgtuLErLuPgPN+ndJnxo0iGtN01B/FyOl+SECQQDH43BgtpfkykC0Fjg3iRAB9qvEqD7Degc2FDZTzDCXFaMnqsc8v1/2HC6oHa2Q/lq1/IOmN/kZGkSfwknA1vkTAkEAq6rtL5BGaKDc6W1/qNjSQGS/YM4MV5w3vax+dzo2I20HQ+3GnGGdWUcXoS/P94rTyFMuLWaUGwOXuVi+GwUBdwJAMrvdeA6gOufCyHKjTiUxtO3g5wc09vRwBB/ZMievZYmOYbEM5LRGLPc2OGFf/l8wsuQmnfey99Yc+NedVJ67lQJAa9M0n4dzcgx4NXY9lQR7K08cleVWA0FwEYbi+Ghr0NyOj7At69O0TXtF8ExjyAw+8bitbH7d0An1psmCvt3qCQJBAJ0cU6kRQ2xy3o7YC74IyC+diAFEUa5YkWzfYssuLdWKsnzhwuxBfzaddQ6FRogUGa25z7SOzpzWpXyH/5dXEyo=";
    //对数据进行加密
    NSString *sign = [RSAEncryptor sign:origin withPriKey:privateKey];
    NSLog(@"签名:%@",sign);

    //后台验签
    [self requestWithParam:@{@"sign":sign==nil?@"":sign} withUrlString:@"http://localhost:8080/api/v1.0/testAPI3"];

    //本地验签
    NSString *publicKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCGCmJL7KLKlk2sHmT5GOlIw9cFqEhwfhTaGqrqDRn1jfCRDh9ppe+mabiCvst6jH5MbCVMVGaqcLyrtzCTAWEsj7GLGvYn0TnpLcxr2w4Df//kGLHpGn8Or90fn4SK+Pku5PX94X2WtA8ospagmcz/+Y0WMoHQl5tRs26bWUXa1QIDAQAB";
    BOOL success = [RSAEncryptor verify:origin signature:sign withPublivKey:publicKey];
    NSLog(@"是否验证成功:%@",success?@"YES":@"NO");
    
}

- (void)testEncryptAndDecrypt
{
    NSString *string = [NSString stringWithFormat:@"name=wql&age=12&userId=10000&nickname=Kayle"];
    //加密时密钥不需要转换
    NSString *publicKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCJ24IhJQ54nOYQjl49j9lmwUaJJs9RMoyOwfcEmyXrzKE50XyT3IUxYmfB65Zo4PTHb5OndJQnoJfabvHZVeNKj+9Tmi2BXMnQh3BEN2a6HRXBnkySUbLMf9stHrcoOvDsJrZ0PLA1oIZHEoLyKZD/NFqwA0Xng+Rjtf/o14FvIQIDAQAB";
    NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAInbgiElDnic5hCOXj2P2WbBRokmz1EyjI7B9wSbJevMoTnRfJPchTFiZ8Hrlmjg9Mdvk6d0lCegl9pu8dlV40qP71OaLYFcydCHcEQ3ZrodFcGeTJJRssx/2y0etyg68OwmtnQ8sDWghkcSgvIpkP80WrADReeD5GO1/+jXgW8hAgMBAAECgYBCkMCT+o2zRad9ZREyTqxeBoNlpFzEy1C9egEpszSrWEKdZX7u8rNJtkd9hqE5AS6QwlqcqBkFzXClo56aH/PAjIF/2dAhAhrdvNABrxB2h/PdUkTL5XCck1TNy04jzUgxULW/7BScQ0K68A7LNu7282ZzhIG0tYF0aCBObsLE8QJBANuC/iQIoT4aOrhMDwcHeRajgQrB7TekAw1BmOoXOGqzVOHl08b6Gv/NaYXM9QUwK84thpobjApl9+RTZ83jSm0CQQCgxdX9JVibTSRxKjj3XtxiqHnA6n+9zmiZAcgsV2Uo7bMnqsUPJ0CkgAZ4JA5DIDrni1wDM1O9NCRPH7SiKAcFAkBhaVkUbov3fjZOsNn+WY+fv0E1n+eASJVeHZ0ZTOKpXxmtAYuggj7XA7XvPYwCGGVoIoXX/59+wc9nEKhBErtlAkBbJk7gKuBFjELw9eM+PEXumV4OBeVOk0uyE9SNby8nOTytbKA0qyh3Gy6PxsFfRVKgG96a4erEBl/fjDY5CUCRAkEAkZh2Gl1QEnEO2SR/hNnKI60KpGWzt0JNva2EvUZV8eChK8LUqLktggM3M6BOV0jSxpP6YKM+X3eZeFpgvUO4iA==";
    NSLog(@"加密前:%@",string);

    //加密
    NSString *encryptString = [RSAEncryptor encryptString:string publicKey:publicKey];
    NSLog(@"加密后:%@",encryptString);
    
    //本地解密
    NSString *decryptString = [RSAEncryptor decryptString:encryptString privateKey:privateKey];
    NSLog(@"解密后:%@",decryptString);

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:encryptString forKey:@"data"];
    //后端解密
    [self requestWithParam:param withUrlString:@"http://localhost:8080/api/v1.0/testAPI4"];
    
}


#pragma mark - 网络请求

- (void)requestWithParam:(NSDictionary*)param withUrlString:(NSString*)urlString
{
    
    //1 获取URL
    NSURL *url = [NSURL URLWithString:urlString];
    //构建请求参数
    
    //2 初始化manager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // manager的响应类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //3 使用AFNetWorking的GET方法进行网络请求
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [manager GET:url.absoluteString parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = (NSDictionary*)responseObject;
                NSLog(@"dic:%@",dic);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
        }];
        
        
        
    });
    
}


@end
