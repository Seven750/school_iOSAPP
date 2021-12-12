//
//  basicsNetworkRequest.m
//  yzsf
//
//  Created by 卿伟明 on 2021/12/1.
//

#import "basicsNetworkRequest.h"

@implementation basicsNetworkRequest

+ (AFHTTPSessionManager *)netWorkManager{
    
    AFHTTPSessionManager *Manager = [AFHTTPSessionManager manager];
    return Manager;
}

@end
