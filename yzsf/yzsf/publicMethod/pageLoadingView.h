//
//  pageLoadingView.h
//  yzsf
//
//  Created by 卿伟明 on 2021/12/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface pageLoadingView : UIView

@property (nonatomic, copy) NSString *loadingInfo;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
