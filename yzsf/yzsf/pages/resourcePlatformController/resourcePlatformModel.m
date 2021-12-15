//
//  resourcePlatformModel.m
//  yzsf
//
//  Created by 卿伟明 on 2021/12/2.
//

#import "resourcePlatformModel.h"

@implementation resourcePlatformModel


- (void)getTopNewsInfoPage:(NSInteger)pageNum Block:(responseBlcok)block
{
    topNewsRequest *req = [topNewsRequest new];
    req.key = @"5fd5cc1bd54acfc621ce335410f06fee";
    req.type = @"keji";
    req.page = pageNum;
    req.page_size = 10;
    req.is_filter = 1;
    
    [getTopNews getTopNewWithRequest:req withResponseBlcok:^(NSMutableArray * _Nonnull resultArr) {
        block(resultArr);
    }];
}

- (UICollectionViewFlowLayout *)collectionViewLayoutSet
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((SCREENWIDTH -20)/3.0, 100);//每一个cell的大小
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//滚动方向
//    CGFloat margin = (SCREENWIDTH - 80) *0.5;
    layout.sectionInset = UIEdgeInsetsMake(4, 10, 4, 10);//四周的边距
    //设置最小边距   line是滚动方向的cell之间   另一个是垂直于滚动方向cell之间的间距
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    return layout;
}


@end
