//
//  resourcePlatformModel.h
//  yzsf
//
//  Created by 卿伟明 on 2021/12/2.
//

#import <Foundation/Foundation.h>
#import "util.h"
#import "getTopNews.h"
NS_ASSUME_NONNULL_BEGIN

typedef void (^responseBlcok)(NSMutableArray *resultArr);

@interface resourcePlatformModel : NSObject

- (void)getTopNewsInfoPage:(NSInteger)pageNum Block:(responseBlcok)block;

- (UICollectionViewFlowLayout *)collectionViewLayoutSet;
@end

NS_ASSUME_NONNULL_END
