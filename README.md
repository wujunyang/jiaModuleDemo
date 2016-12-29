# jiaModuleDemo

jiaModuleDemo项目是为了解决关于项目中如何进行模块化开发而编写的实例，包含如何进行路由式、本地模块间交互的实现；目前还是在页面层级进行抽离，对于项目中各个模块共有的基础功能也进行提取，可以结合私有Pods进行管理；

#项目中存在的问题
```obj-c
问题一：页面耦合严重
```
<img src="https://github.com/wujunyang/jiaModuleDemo/blob/master/jiaModuleDemo/ProjectImage/7.png" width=800px height=400px></img>

上面这张图中左边体现了目前项目中存在的问题，对于页面之间相互耦合，而页面之间的传参也各不相同，由于不同的开发人员或者简便方式等原因，传参的类型都有差异，包含如实体、简单基本类型等，先前项目对于路由方式也不支持，导致要实现收到消息推送进行不同的页面跳转存在硬编码情况，对于功能扩展存在相当大的问题；而右边则是模块化后页面之间的交互方式；页面之间也不存在耦合关系，都只跟JiaMediator这个中介者相依赖；而传参都统一成以字典的形式；虽然可能牺牲一些方便跟随意，却可以解耦模块化；并且加入对路由方式的处理；约定好相关的协议进行交互；用这种路由方式代替那些第三方的路由插件则是因为它的灵活性，最主要还是省去了第三方路由插件在启动时要注册路由的问题；

```obj-c
问题二：相同模块重复开发
```
<img src="https://github.com/wujunyang/jiaModuleDemo/blob/master/jiaModuleDemo/ProjectImage/9.png" width=800px height=400px></img>

当公司里面有多个项目同时进行，并且有可能是多个人分别不同项目时，就会存在如上图出现的情况，其实每个APP中都是有很多共同的模块，当然有可能你会把相同功能模块代码复制一份在新项目中，但这其实并不是最好的方式，在后期不断迭代过程中，不同的人会往里面增加很多带有个人色彩的代码；这样就像相同的模块项目后期对于多个项目统一管理也是灾难性，有可能会失控，哪怕项目转移别人接手也会无形中浪费很多时间，增加维护成本，所以实例中更注重对于一些相同模块进行提取，求同存异；而模块化结合私有Pods进行管理，对于常用功能的封装，只要开放出一些简单开关配置方式，就可以实现一个功能，比如日志记录、网络请求模块、网络状态变化提示等；


#模块化解决方案

###页面交互解耦

<img src="https://github.com/wujunyang/jiaModuleDemo/blob/master/jiaModuleDemo/ProjectImage/1.png" width=500px height=400px></img>

```obj-c

```

实现调用代码：

```obj-c
NSDictionary *curParams=@{kDesignerModuleActionsDictionaryKeyName:@"wujunyang",kDesignerModuleActionsDictionaryKeyID:@"1001",kDesignerModuleActionsDictionaryKeyImage:@"designerImage"};
    switch (indexPath.row) {
        case 0:
        {
            UIViewController *viewController=[[JiaMediator sharedInstance]JiaMediator_Designer_viewControllerForDetail:curParams];
            [self presentViewController:viewController animated:YES completion:nil];
            break;
        }
        case 1:
        {
            UIViewController *viewController=[[JiaMediator sharedInstance]JiaMediator_Designer_viewControllerForDetail:curParams];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        case 2:
        {
            NSString *curRoue=@"jiaScheme://Designer/nativeFetchDetailViewController?name=wujunyang&ID=1001&image=designerImage";
            UIViewController *viewController=[[JiaMediator sharedInstance]performActionWithUrl:[NSURL URLWithString:curRoue] completion:^(NSDictionary *info) {
                
            }];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        default:
            break;
    }
```
`上面针对本地模块调用及路由方式调用的跳转`

1：JiaMediator起到一个中介的作用，所有的模块间响应交互都是通过它进行，每个模块都会对它进行扩展分类（例如：JiaMediator+模块A），分类主要是为了用于本地间调用而又不想用路由的方式，若要用路由的方式则要注意关于路由约束准确编写，它将会直接影响到能否正确响应到目标；

<img src="https://github.com/wujunyang/jiaModuleDemo/blob/master/jiaModuleDemo/ProjectImage/3.png" width=200px height=400px></img>

2：JiaMediator是每个模块都要用到的内容，可以把它放在公共的模块中，因为关于各个模块的JiaMediator由每个模块自个负责，开放给要调用的模块使用；



3：为了解耦对于页面间的传参都采用字典形式，项目中所有的页面都继承于一个基页面jiaBaseViewController，里面已经有对初始化对于字典参数的接收并赋值，每个模块的子页面只要调用parameterDictionary属性，就可以获取关于参数的内容；同样jiaBaseViewController也是每个模块都要使用，所以也被提取在公共里面，其还包括一些导栏条的封装及关于网络状态变化的提示等；



```obj-c

//页面接收参数
@property(nonatomic,strong)NSDictionary *parameterDictionary;
//初始化参数
- (id)initWithRouterParams:(NSDictionary *)params;


- (id)initWithRouterParams:(NSDictionary *)params {
    self = [super init];
    if (self) {
        _parameterDictionary=params;
        NSLog(@"当前参数：%@",params);
    }
    return self;
}
```

<img src="https://github.com/wujunyang/jiaModuleDemo/blob/master/jiaModuleDemo/ProjectImage/2.png" width=500px height=400px></img>

4：当响应某一个模块目标后，将会把相应的viewController进行返回，而对于具体如何操作则是在获得当前控制器自行处理，比如是跳转还是弹出展现；

5：为了减少对于字典参数key拼写错误问题，每个模块都有一个对应key值的常量配置文件，已经把对应的key值都定义成的常量，方便调用；

```obj-c
#ifndef HeaderDesignerConfig_h
#define HeaderDesignerConfig_h

//键值
static NSString * const kDesignerModuleActionsDictionaryKeyName=@"name";
static NSString * const kDesignerModuleActionsDictionaryKeyID=@"ID";
static NSString * const kDesignerModuleActionsDictionaryKeyImage=@"image";

#endif /* HeaderDesignerConfig_h */

```

```obj-c

 NSDictionary *curParams=@{kDesignerModuleActionsDictionaryKeyName:@"wujunyang",kDesignerModuleActionsDictionaryKeyID:@"1001",kDesignerModuleActionsDictionaryKeyImage:@"designerImage"};

```

###JiaCore(基础功能封装)

JiaCore是整个APP最基础模块，所有的模块化都要依赖，主要包含一些全局的功能模块，比如JiaBaseViewController、JiaAppDelegate等；目前已经把一些默认的功能进行集成在里面，包含网络状态变化判断及提示、日志记录功能等；并把一些相关配置的内容用JiaCoreConfigManager这个管理类进行统一设置，比如是否打开日志记录功能；JiaCoreConfigManager类则是开放给具体APP设置全局的相关配置；下面就以其中一个日志记录功能进行讲解:

```obj-c
//JiaCore基础模块相关配置
JiaCoreConfigManager *jiaCoreConfig=[JiaCoreConfigManager sharedInstance];
jiaCoreConfig.recordlogger=YES;
```
然后具体APP的PrefixHeader.pch引入命名空间并进行设置记录日志的等级：
```obj-c
#import "JiaCocoaLumberjack.h"

//DDLog等级
static const int ddLogLevel = DDLogLevelVerbose;
```
这样就完成的一个APP对于日志记录模块的引入，JiaCore已经帮你完成的关于日志记录的相关配置，并且错误内容以一种可读性较好的格式记录到file文件中，而且这些file文件生成规则也都定义好了，当然如何时你要是在Xcode控制台显示不同等级色彩，只要安装XcodeColors插件并简单进行设置就可以了，对于不同等级不同色彩都已经在JiaCore配置完成；

在JiaCore里面也默认集成了热更新的功能，只要传入简单的对象数组就会启动热更新；其中JiaPathchModel已经是定义好的模型，在APP中把接口请求转化成模型数组，其中patchId是唯一值名称、md5则是JS文件的MD5值、url是JS的下载路径、ver则是对哪个版本起作用；因为一般我们在外面的APP都是多版本共存，热更新也要进行版本区分，只下载与本版本相对应的热更新JS文件加载；而MD5值则是为了增加安全性，避免JS文件被别人进行修改而影响APP的运行，在JiaCore会对下载后的JS文件进行MD5计算并比较；对于没有在jSPatchMutableArray以前的JS文件会被删除；

```obj-c
//热更新内容
JiaPathchModel *sample=[[JiaPathchModel alloc]init];
sample.patchId = @"patchId_sample1";
sample.md5 = @"2cf1c6f6c5632dc21224bf42c698706b";
sample.url = @"http://test.qshmall.net:9090/demo1.js";
sample.ver = @"1";
    
JiaPathchModel *sample1=[[JiaPathchModel alloc]init];
sample1.patchId = @"patchId_sample2";
sample1.md5 = @"e8a4eaeadce5a4598fb9a868e09c75fd";
sample1.url = @"http://test.qshmall.net:9090/demo2.js";
sample1.ver = @"1";

//JiaCore基础模块相关配置
JiaCoreConfigManager *jiaCoreConfig=[JiaCoreConfigManager sharedInstance];
jiaCoreConfig.jSPatchMutableArray=[@[sample,sample1] mutableCopy];
```

###JiaNetWork(网络交互封装)

对于网络请求模块则采用YTKNetwork，底层还是以AFNetworking进行网络通信交互，定义一个继承于YTKBaseRequest的JiaBaseRequest，针对JiaBaseRequest则是为了后期各个APP可以对它进行分类扩展，对于一些超时、请求头部等进行统一个性化设置，毕竟这些是每个APP都不相同；而针对模块中关于请求网络的前缀设置，则在每个模块中都有一个单例的配置类，此配置类是为了针对该模块对不同APP变化而定义；相应的配置内容开放给APP，由具体APP来定义，例如现在项目中的JiaBaseRequest+App.h类，里面有简单设置超时跟头部；当然记得把这个分类引入到APP中，比如AppPrefixHeader这个APP的全局头部；

```obj-c
#import "JiaBaseRequest+App.h"

@implementation JiaBaseRequest (App)

- (NSTimeInterval)requestTimeoutInterval {
    return 15;
}

//公共头部设置
- (NSDictionary *)requestHeaderFieldValueDictionary
{
    NSDictionary *headerDictionary=@{@"platform":@"ios"};
    return headerDictionary;
}

@end
```

```obj-c
网络层整体实现如下：
```
<img src="https://github.com/wujunyang/jiaModuleDemo/blob/master/jiaModuleDemo/ProjectImage/4.png" width=500px height=400px></img>



###JiaGT模块(个推封装)

消息推送对于一个APP是相当重要性，一般是采用第三方的SDK进行集成，其实大部分的SDK处理代码都是差不多，在这实例中对差异化的内容进行提取，实例中将以个推进行模块化，因为消息推送的大部分代码都集中在AppDelegate中，造成的一大堆杂乱代码，当然也有一部分人对AppDelegate进行扩展分类进行移除代码，实例中将采用另外一种解决方案进行抽取，可以达到完全解耦，在具体的APP里面将不会再出现个推SDK相关内容，只要简单进行配置跟处理消息就可以，下面只是简单的列出部分代码，其它封装代码见源代码；
```obj-c
//设置个推模块的配置
jiaGTConfigManager *gtConfig=[jiaGTConfigManager sharedInstance];
gtConfig.jiaGTAppId=@"0uuwznWonIANoK07JeRWgAs";
gtConfig.jiaGTAppKey=@"26LeO4stbrA7TeyMUJdXlx3";
gtConfig.jiaGTAppSecret=@"2282vl0IwZd9KL3ZpDyoUL7";
```
```obj-c
#pragma mark 消息推送相关处理

/**
 *  @author wujunyang, 16-07-07 16:07:25
 *
 *  @brief  处理个推消息
 *
 *  @param NotificationMessage
 */
-(void)gtNotification:(NSDictionary *)NotificationMessage
{
    NSLog(@"%@",NotificationMessage[@"payload"]);
    NSLog(@"－－－－－接收到个推通知------");
}


/**
 *  @author wujunyang, 16-07-07 16:07:40
 *
 *  @brief  处理远程苹果通知
 *
 *  @param RemoteNotificationMessage
 */
-(void)receiveRemoteNotification:(NSDictionary *)RemoteNotificationMessage
{
    NSLog(@"%@",RemoteNotificationMessage[@"message"]);
    NSLog(@"－－－－－接收到苹果通知------");
}

/**
 *  @author wujunyang, 16-09-21 14:09:33
 *
 *  @brief 获得注册成功时的deviceToken 可以在里面做一些绑定操作
 *
 *  @param deviceToken <#deviceToken description#>
 */
-(void)receiveDeviceToken:(NSString *)deviceToken
{
    NSLog(@"－－－－－当前deviceToken：%@------",deviceToken);
}
```
<img src="https://github.com/wujunyang/jiaModuleDemo/blob/master/jiaModuleDemo/ProjectImage/5.png" width=500px height=400px></img>

上面能够对个推进行完全的解耦不得不提一个第三方的插件XAspect，如果想对它进行了解可以在github进行查找；它的主要作用如下图，可以用它进行其它第三方SDK的抽离

<img src="https://github.com/wujunyang/jiaModuleDemo/blob/master/jiaModuleDemo/ProjectImage/6.png" width=500px height=400px></img>


###JiaAnalytics模块(友盟统计封装)

JiaAnalytics模块是在友盟统计SDK跟Aspect相结合基础上完成，对于页面的进出统计采用Aop切面方式进行，把原本应该在每个页面生命周期的统计代码移除，App运用只要简单配置友盟相对应的信息，也可以设置要统计页面的过滤条件，目前已经有三种如要统计的开头页面的前缀字符串数组、要统计的页面名称字符串数组、不统计的页面名称字符串数组；可以结合使用，达到精确统计页面的目的；而且把统计的代码放在异步线程进行，不会影响主线程的响应；

```obj-c
__weak typeof(self) ws = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info, BOOL animated){
            UIViewController *controller = [info instance];
            BOOL filterResult=[ws fileterWithControllerName:NSStringFromClass([controller class])];
            if (filterResult) {
                [ws beginLogPageView:[controller class]];
            }
        } error:NULL];
        
        [UIViewController aspect_hookSelector:@selector(viewWillDisappear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info, BOOL animated){
            UIViewController *controller = [info instance];
            BOOL filterResult=[ws fileterWithControllerName:NSStringFromClass([controller class])];
            if (filterResult) {
                [ws endLogPageView:[controller class]];
            }
        } error:NULL];
    });

```

<img src="https://github.com/wujunyang/jiaModuleDemo/blob/master/jiaModuleDemo/ProjectImage/10.png" width=500px height=400px></img>


###JiaShare模块(友盟分享及第三方登录封装)

JiaShare模块运用友盟分享最新版的SDK进行封装，并把一些其它不是很常用的去除，目前只支持新浪、微信聊天、微信朋友圈、QQ聊天页面、qq空间、腾讯微博；分享包括纯文本、图文、URL、视频地址、音乐地址，并在里面已经运用JavaScriptCore.framework封装好关于H5页面调用分享并传参的功能；可以直接在UIWebView里面进行调用；本模块只是对功能进行封装，对于友盟在info.plist的配置还是要自行手动，如不明白可以直接到友盟分享官网查看，项目到也有配置好一份可以直接参考；JiaPlatformHelper类里面有一个判断当前手机是否有安装相应平台软件的方法，可以用它进行隐藏相应的操作功能，避免上架时审核不过；下面的代码是在项目的AppDelegate里面进行配置

```obj-c
//友盟分享
JiaShareConfigManager *jiaShareConfig=[JiaShareConfigManager sharedInstance];
jiaShareConfig.shareAppKey=@"57e3f1cbe0f55a42080011ec";
jiaShareConfig.shareLogEnabled=YES;
//设置平台
[jiaShareConfig setPlaform:JiaSocialPlatConfigType_Tencent appKey:@"100424468" appSecret:@"c7394704798a158208a74ab60104f0ba" redirectURL:@"http://www.umeng.com/social"];
[jiaShareConfig setPlaform:JiaSocialPlatConfigType_Wechat appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://www.umeng.com/social"];
[jiaShareConfig setPlaform:JiaSocialPlatConfigType_Sina appKey:@"3921700954" appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
```

然后就可以进行分享，在ViewController里面进行调用，JiaSocialPlatformType是分享平台的枚举，shareUrlDataWithPlatform为URL分享方式，其它可以直接见源代码JiaShareHelper类

```obj-c
    [JiaShareHelper shareUrlDataWithPlatform:JiaSocialPlatformType_WechatSession withShareUrl:@"http://www.sina.com.cn" withTitle:@"新浪" withDescr:@"新浪网页" withThumImage:@"http://dev.umeng.com/images/tab2_1.png" withCompletion:^(id result, NSError *error) {
        if(error)
        {
            NSLog(@"分享出错了");
        }
    }];
```

如果有加载H5页面，而且也要进行分享的功能就可以使用JiaWebShareHelper,因为使用到的是JavaScriptCore，所以只能用在UIWebView中，如果你要是使用WKWebView可以自个再进行封闭，下面是加载H5页面中的webViewDidFinishLoad代码；

```obj-c
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    // 通过模型调用方法，这种方式更好些。
    JiaWebShareHelper *shareHelper  = [[JiaWebShareHelper alloc] init];
    self.jsContext[@"jia"] = shareHelper;
    shareHelper.jsContext = self.jsContext;
    shareHelper.webView = self.webView;
    
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
}
```

H5中就可以很方便直接进行：

```obj-c
<input type="button" value="分享QQ纯文本" onclick="jia.shareText('qq','你好，我是测试')">
        
<input type="button" value="分享微信URL" onclick="jia.shareUrl('wechatsession','http://www.sina.com','你好，我是测试','测试用','http://dev.umeng.com/images/tab2_1.png')">
            
<input type="button" value="分享微信朋友圈URL" onclick="jia.shareUrl('wechattimeline','http://www.sina.com','你好，我是测试','测试用','http://dev.umeng.com/images/tab2_1.png')">
                        
<input type="button" value="分享QQ空间图文" onclick="jia.shareImageText('qzone','http://dev.umeng.com/images/tab2_1.png','你好，我是测试','测试用','http://dev.umeng.com/images/tab2_1.png')">
```

下面简单介绍关于第三方登录跟获取用户信息的功能，其功能代码放在JiaPlatformHelper里面，已经对授权成功及获取用户信息都有回去调相应的参数回来：

```obj-c
if(![JiaPlatformHelper installPlatAppWithType:JiaSocialPlatformType_QQ])
{
    [weakSelf showResult:@"没有安装QQ软件,将此功能隐藏"];
    return;
}
            
[JiaPlatformHelper authWithPlatform:JiaSocialPlatformType_QQ withCompletion:^(NSString *uid, NSString *openid,NSString *accessToken, NSError *error) {
    if (error) {
        NSLog(@"出错了");
        return;
          }
                
    NSString *result=[NSString stringWithFormat:@"获得到的值为：uid:%@--token:%@--openid:%@",uid,accessToken,openid];
    [weakSelf showResult:result];
}];
```

获取用户信息的代码如下：

```obj-c
[JiaPlatformHelper getUserInfoWithPlatform:JiaSocialPlatformType_QQ withCompletion:^(NSString *name, NSString *iconUrl, NSString *gender, NSError *error) {
   if (error) {
      NSLog(@"出错了");
      return;
    }
                
   NSString *result=[NSString stringWithFormat:@"获得到的值为：name:%@--性别:%@",name,gender];
   [weakSelf showResult:result];
}];
```

关于取消授权也有相应的方法：

```obj-c
[JiaPlatformHelper cancelAuthWithPlatform:JiaSocialPlatformType_QQ withCompletion:^(id result, NSError *error) {
   if (error) {
      NSLog(@"出错了");
      return;
     }
                
   NSString *ressult=@"取消成功";
   [weakSelf showResult:ressult];
}];
```

<img src="https://github.com/wujunyang/jiaModuleDemo/blob/master/jiaModuleDemo/ProjectImage/11.png" width=500px height=400px></img>

#模块化结合私有Pods方案
上面实例中只是把相关模块化的提取都在一个工程进行体现，最后还是要落实结合Pods进行管理，把每个模块分开管理，不同的APP可以简单通过Pods指令就可以达到引入模块的效果，对于一些相同模块可以在不同的APP重复引用，减小重复开发成本；

<img src="https://github.com/wujunyang/jiaModuleDemo/blob/master/jiaModuleDemo/ProjectImage/8.png" width=700px height=500px></img>

在本项目中已经引入的Pod来管理目前开发的几个模块，并导入在我目前的Github的一个库里Spec进行统一管理，首先要引入Pod来管理则要增加jiaModule.podspec文件；

```obj-c
Pod::Spec.new do |s|

s.name         = "jiaModule"
s.version      = "0.0.9"
s.summary      = "iOS模块化功能的引用"

s.homepage     = "https://github.com/wujunyang/jiaModuleDemo"
s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
s.author             = { "wujunyang" => "wujunyang@126.com" }

s.platform     = :ios, "7.0"

s.source       = { :git => "https://github.com/wujunyang/jiaModuleDemo.git", :tag => "#{s.version}" }

s.requires_arc = true

s.subspec 'JiaCore' do |jiaCore|
jiaCore.source_files = 'jiaModuleDemo/BaseModule/JiaCore/**/*.{h,m}'
jiaCore.dependency 'XAspect'
jiaCore.dependency 'YYCache'
jiaCore.dependency 'JSPatch'
jiaCore.dependency 'RealReachability'
jiaCore.dependency 'FLEX', '~> 2.0'
jiaCore.dependency 'CocoaLumberjack', '~> 2.0.0-rc'
jiaCore.dependency 'AFNetworking', '~> 3.0'
end

s.subspec 'JiaGT' do |jiaGT|
jiaGT.source_files = 'jiaModuleDemo/BaseModule/JiaGT/**/*'
jiaGT.dependency 'jiaModule/JiaCore'
jiaGT.dependency 'XAspect'
jiaGT.dependency 'GTSDK'
end

s.subspec 'JiaAnalytics' do |jiaAnalytics|
jiaAnalytics.source_files = 'jiaModuleDemo/BaseModule/JiaAnalytics/**/*'
jiaAnalytics.dependency 'jiaModule/JiaCore'
jiaAnalytics.dependency 'XAspect'
jiaAnalytics.dependency 'Aspects'
jiaAnalytics.dependency 'UMengAnalytics-NO-IDFA', '~> 4.1.1'
end


s.subspec 'JiaShare' do |jiaShare|
jiaShare.source_files = 'jiaModuleDemo/BaseModule/JiaShare/**/*'
jiaShare.dependency 'jiaModule/JiaCore'
jiaShare.dependency 'XAspect'
jiaShare.dependency 'UMengUShare/UI'
jiaShare.dependency 'UMengUShare/Social/Sina'
jiaShare.dependency 'UMengUShare/Social/WeChat'
jiaShare.dependency 'UMengUShare/Social/QQ'
jiaShare.dependency 'UMengUShare/Social/TencentWeibo'
end



s.frameworks = 'UIKit'

# s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
# s.dependency "JSONKit", "~> 1.4"
end


```

上面的文件会把不同的模块进行分离，可以一起引入也可以单独引入某一个模块；pod会自动把相应的依赖都引入,下面是全部引入关于jiaModule模块

```obj-c
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/wujunyang/WjySpecs.git'
platform :ios, "7.0"

pod 'jiaModule'
```

假如要引入只是其中一个模块：

```obj-c
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/wujunyang/WjySpecs.git'
platform :ios, "7.0"

pod 'jiaModule/JiaCore’
pod 'jiaModule/JiaGT’
```

下面简单介绍两条关于验证跟提交jiaModule.podspec的指令，都要打开终端进入项目根目录，也就是jiaModule.podspec所在的目录，然后进行执行；

```obj-c
#验证是否正确（后面还有一个git的私有地址)
pod lib lint jiaModule.podspec --allow-warnings --use-libraries --sources=https://github.com/CocoaPods/Specs.git,https://github.com/wujunyang/WjySpecs.git

#提交到库  (specs就是你们的私有库名，见下面repo add指令时的名字，后面还有一个git的私有地址)
pod repo push specs jiaModule.podspec --allow-warnings --use-libraries --sources=https://github.com/CocoaPods/Specs.git,https://github.com/wujunyang/WjySpecs.git
```

注意：如果提交到库时报下面的问题，说明还没有把私有仓库集下载到本地：

```obj-c
[!] Unable to find the `specs` repo. If it has not yet been cloned, add it via `pod repo add`.
```

可以直接执行指令（specs名字可以自行定义，跟上面提交时对应该上就行）：

```obj-c
pod repo add specs https://github.com/wujunyang/WjySpecs.git
```

会在路径：/Users/自个电脑用户名/.cocoapods/repos（被隐藏，要用指令进行显示出来） 下有一个文件夹specs 另外还有一个是Pod官网的文件夹；

最后还要登录Git账号跟密码，就可以成功提交了

```obj-c
Username for 'https://github.com': wujunyang@126.com
Password for 'https://wujunyang@126.com@github.com': 
To https://github.com/wujunyang/WjySpecs.git
   80ca876..d4f7446  master -> master
```
