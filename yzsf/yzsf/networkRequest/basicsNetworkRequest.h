//
//  basicsNetworkRequest.h
//  yzsf
//
//  Created by 卿伟明 on 2021/12/1.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "NSDictionary+category.h"

NS_ASSUME_NONNULL_BEGIN

@interface basicsNetworkRequest : NSObject

+ (AFHTTPSessionManager *)netWorkManager;

@end

NS_ASSUME_NONNULL_END
