//
//  getTopNews.h
//  yzsf
//
//  Created by 卿伟明 on 2021/12/1.
//

#import "basicsNetworkRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface topNewsRequest : NSObject
@property (strong,nonatomic) NSString *key;  //接口key, 在个人中心->我的数据,接口名称上方查看
@property (strong,nonatomic) NSString *type;   // 非必需   支持类型top(推荐,默认) guonei(国内) guoji(国际) yule(娱乐) tiyu(体育) junshi(军事) keji(科技) caijing(财经) shishang(时尚) youxi(游戏) qiche(汽车) jiankang(健康)
@property (assign,nonatomic)  NSInteger page;  // 非必需    当前页数, 默认1, 最大50
@property (assign,nonatomic)  NSInteger  page_size;  //非必需    每页返回条数, 默认30 , 最大30
@property (assign,nonatomic)  NSInteger  is_filter;   //非必需    是否只返回有内容详情的新闻, 1:是, 默认0

+ (NSMutableDictionary *)initWithDRequest:(topNewsRequest *)req;
@end

@interface TopNewsResponse : NSObject
@property (nonatomic, strong) NSString *category;    //新闻分类
@property (nonatomic, strong) NSString *is_content;   //是否有新闻内容,1表示有 可以通过查询新闻详细内容小接口获取新闻内容
@property (nonatomic, strong) NSString *thumbnail_pic_s;   //新闻图片链接
@property (nonatomic, strong) NSString *uniquekey;    //新闻ID
@property (nonatomic, strong) NSString *title;    //新闻标题
@property (nonatomic, strong) NSString *date;     //新闻时间
@property (nonatomic, strong) NSString *author_name;  //新闻来源
@property (nonatomic, strong) NSString *thumbnail_pic_s03;
@property (nonatomic, strong) NSString *thumbnail_pic_s02;
@property (nonatomic, strong) NSString *url;   //新闻访问链接

+ (instancetype)initWithDict:(NSDictionary *)dict;
@end


typedef void (^responseBlcok)(NSMutableArray * _Nullable resultArr);
@interface getTopNews : basicsNetworkRequest

+(void)getTopNewWithRequest:(topNewsRequest *)req withResponseBlcok:(responseBlcok)block;

@end


NS_ASSUME_NONNULL_END
