//
//  NSDictionary+category.m
//  yzsf
//
//  Created by 卿伟明 on 2021/12/1.
//

#import "NSDictionary+category.h"

@implementation NSDictionary (category)

-(void)createPropertyCode{
 NSMutableString *codes = [NSMutableString string];
    // 遍历字典
   [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
         NSString *code;
         if ([value isKindOfClass:[NSString class]]) {
             //NSString类型
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSString *%@;",key];
        } else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]) {//字符串转为Class
            //BOOL类型
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",key];
        } else if ([value isKindOfClass:[NSNumber class]]) {
            //NSInteger类型
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@;",key];
        } else if ([value isKindOfClass:[NSArray class]]) {
            //NSArray类型
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",key];
        } else if ([value isKindOfClass:[NSDictionary class]]) {
            //NSDictionary类型
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;",key];
        }
        [codes appendFormat:@"\n%@\n",code];
    }];
   NSLog(@"%@",codes);
}
@end
