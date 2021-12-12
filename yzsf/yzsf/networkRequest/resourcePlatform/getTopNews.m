//
//  getTopNews.m
//  yzsf
//
//  Created by 卿伟明 on 2021/12/1.
//

#import "getTopNews.h"

@implementation topNewsRequest

+ (NSMutableDictionary *)initWithDRequest:(topNewsRequest *)req
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (req.key) {
        [dic setObject:req.key forKey:@"key"];
    }
    if (req.type) {
        [dic setObject:req.type forKey:@"type"];
    }
    
    [dic setValue:@(req.page) forKey:@"page"];
    [dic setValue:@(req.page_size) forKey:@"page_size"];
    [dic setValue:@(req.is_filter) forKey:@"is_filter"];
    return dic;
}

@end

@implementation TopNewsResponse

- (instancetype)initWithDict:(NSDictionary *)dict
{
   if(self = [super init])
    {
        self.category = [dict[@"category"] stringByRemovingPercentEncoding];
        self.is_content = dict[@"is_content"];
        self.thumbnail_pic_s = dict[@"thumbnail_pic_s"];
        self.uniquekey = dict[@"uniquekey"];
        self.title = dict[@"title"];
        self.date = dict[@"date"];
        self.author_name = [dict[@"author_name"] stringByRemovingPercentEncoding];
        self.thumbnail_pic_s03 = dict[@"thumbnail_pic_s03"];
        self.thumbnail_pic_s02 = dict[@"thumbnail_pic_s02"];
        self.url = dict[@"url"];
    }
  return self;
}

+ (instancetype)initWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end


@implementation getTopNews

+(NSString *) getUrl{
    return @"http://v.juhe.cn/toutiao/index";
}


+(void)getTopNewWithRequest:(topNewsRequest *)req withResponseBlcok:(responseBlcok)responseBlcok
{
    /*
     第一个参数：请求路径（nsstring）
     第二个参数：字典（发送给服务器的参数 ，dict）
     第三个参数：headers 进度回调 一般填nil
     第四个参数：progess 进度回调 一般填nil
     第五个参数： success 成功回调
     task:请求任务
     responseObject:响应体信息(JSON--->OC对象)
     第六个参数:failure 失败回调
     error:错误信息
     响应头:task.response
    */
    
    NSMutableDictionary *dic = [topNewsRequest initWithDRequest:req];
    [[self netWorkManager] POST:[self getUrl] parameters:dic headers:nil progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject objectForKey:@"error_code"] && [[responseObject valueForKey:@"error_code"] longValue]!= 0 ) {
            responseBlcok(nil);
        }else{
            NSDictionary *result = [responseObject valueForKey:@"result"];
            NSArray *arr = [result valueForKey:@"data"];
            NSMutableArray *resultArr = [[NSMutableArray alloc] init];
            for (int i = 0; i<arr.count; i++) {
                NSDictionary *dic=arr[i];
                TopNewsResponse *rep = [TopNewsResponse initWithDict:dic];
                [resultArr addObject:rep];
            }
            responseBlcok(resultArr);
        }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"请求失败");
         }];
}

@end
