# jiaModuleDemo

jiaModuleDemo项目是为了解决关于项目中如何进行模块化开发而编写的实例，包含如何进行路由式、本地模块间交互的实现；目前还是在页面层级进行抽离，对于项目中各个模块共有的基础功能也进行提取，可以结合私有Pods进行管理；

#整体实现效果图
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
6:对于网络请求模块则采用YTKNetwork，底层还是以AFNetworking进行网络通信交互，在基础全局模块JiaCore中，定义一个继承于YTKBaseRequest的JiaBaseRequest，针对JiaBaseRequest则是为了后期各个APP可以对它进行分类扩展，对于一些超时、请求头部等进行统一个性化设置，毕竟这些是每个APP都不相同；而针对模块中关于请求网络的前缀设置，则在每个模块中都有一个单例的配置类，此配置类是为了针对该模块对不同APP变化而定义；相应的配置内容开放给APP，由具体APP来定义，例如现在项目中的JiaBaseRequest+App.h类，里面有简单设置超时跟头部；当然记得把这个分类引入到APP中，比如AppPrefixHeader这个APP的全局头部；

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
网络交互说明如下：
```
<img src="https://github.com/wujunyang/jiaModuleDemo/blob/master/jiaModuleDemo/ProjectImage/4.png" width=500px height=400px></img>