//
//  PROAlertViewController.m
//  AirPayCounter
//
//  Created by Hongwei Liu on 2019/4/22.
//  Copyright © 2019 Shopee. All rights reserved.
//

#import "PROAlertViewController.h"
#import "PROAlertModel.h"
#import "PROAlertView.h"

#pragma mark - PROAlertAction
@interface PROAlertAction ()

@property (nonatomic, strong) PROAlertActionModel *model;

@end

@implementation PROAlertAction

- (PROAlertActionModel *)model {
    if (!_model) {
        _model = [[PROAlertActionModel alloc] init];
    }
    return _model;
}

- (PROAlertAction * _Nonnull (^)(NSString * _Nullable))title {
    return ^PROAlertAction * _Nonnull (NSString * _Nullable title) {
        self.model.title = title;
        return self;
    };
}

- (PROAlertAction * _Nonnull (^)(PROAlertActionStyle))style {
    return ^PROAlertAction * _Nonnull (PROAlertActionStyle style) {
        self.model.style = style;
        return self;
    };
}

- (PROAlertAction * _Nonnull (^)(void (^ _Nonnull)(id _Nullable)))actionHandler {
    return ^PROAlertAction * _Nonnull (void (^ _Nonnull handler)(id _Nullable)) {
        self.model.actionHandler = handler;
        return self;
    };
}

@end


/**alert池，用于处理同时多个弹框的顺序问题*/
static NSMutableArray *globalAlertPoolArray = nil;

#pragma mark - PROAlertViewController
@interface PROAlertViewController ()


@property (nonatomic, strong) PROAlertModel *model;
@property (nonatomic, strong) PROAlertView *alertView;

@property (nonatomic , copy ) void (^showAlertPoolHandler)(void);

@end

@implementation PROAlertViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupAlertPool];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(appWillEnterForground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MCOLOR_ALPHA(@"#000000", 0.4);
    [self setupSubviews];

}


- (void)appWillEnterForground:(NSNotification *)notification {
    if (self.model.backFromBackground) {
        self.model.backFromBackground();
    }
}

#pragma mark - Public Methods
- (void (^)(void))show {
    mweakify(self);
    return ^void () {
        mstrongify(self);
        if (self.showAlertPoolHandler) self.showAlertPoolHandler();
    };
}

- (void)showAlert {
    self.window.hidden = NO;
    self.window.rootViewController = self;
    [self.window makeKeyAndVisible];

    self.model.show = YES;
    self.view.alpha = 0;
    self.alertView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alertView.alpha = 1;
        self.view.alpha = 1;
    }];
    if (self.model.showHandler) {
        self.model.showHandler();
    }
}

- (void (^)(void))showActionSheet {
    return ^void () {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:self.model.title message:self.model.message preferredStyle:UIAlertControllerStyleActionSheet];
        [self.model.actionArray enumerateObjectsUsingBlock:^(PROAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.model.title.length <= 0) {
                return;
            }
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:obj.model.title style:(UIAlertActionStyle)obj.model.style handler:^(UIAlertAction * _Nonnull action) {
                if (obj.model.actionHandler) {
                    obj.model.actionHandler(action);
                }
            }];
            [alertController addAction:action];
        }];
        [[PROUIUtil topViewController] presentViewController:alertController animated:YES completion:nil];
    };
}

- (void)dismiss {
    [self dismiss:YES];
}

#pragma mark - Private Methods
- (void)dismiss:(BOOL)animation {
    mweakify(self);
  
    if (!animation) {
        self.alertView.alpha = 0;
        self.view.alpha = 0;
        self.model.show = NO;
        [PROAlertViewController removeAlertViewFromPool:self];
        [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
        self.window.hidden = YES;
        self.window.rootViewController = nil;
        [PROAlertViewController continueShowAlertFromPool];
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        mstrongify(self);
        self.alertView.alpha = 0;
        self.view.alpha = 0;
        self.model.show = NO;
        [PROAlertViewController removeAlertViewFromPool:self];
    } completion:^(BOOL finished) {
        mstrongify(self);
        [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
        self.window.hidden = YES;
        self.window.rootViewController = nil;
        [PROAlertViewController continueShowAlertFromPool];
    }];
}

- (void)setupSubviews {
    self.alertView = [[PROAlertView alloc] initWithModel:self.model];
    [self.view addSubview:self.alertView];
    [self.alertView setupContainerMasonry];
    
    mweakify(self);
    self.alertView.firstButtonActionBlock = ^(UIButton * _Nonnull button) {
        mstrongify(self);
               if (self.model.firstButtonHandler) {
                   self.model.firstButtonHandler(button);
               }
               if (!self.model.manualDismissAlert) {
                   [self dismiss:YES];
               }
    };
    self.alertView.secondButtonActionBlock = ^(UIButton * _Nonnull button) {
        mstrongify(self);
              if (self.model.secondButtonHandler) {
                  self.model.secondButtonHandler(button);
              }
              if (!self.model.manualDismissAlert) {
                  [self dismiss:YES];
              }
    };

}

#pragma mark - Getters
- (UIWindow *)window {
    if (!_window) {
        
        _window = [[UIWindow alloc] initWithFrame:[UIApplication sharedApplication].delegate.window.frame];
        _window.backgroundColor = [UIColor clearColor];
        _window.windowLevel = UIWindowLevelAlert;
    }
    return _window;
}

- (PROAlertModel *)model {
    if (!_model) {
        _model = [[PROAlertModel alloc] init];
       
    }
    return _model;
}


- (PROAlertViewController * _Nonnull (^)(UIImage * _Nullable))topImage {
    return ^PROAlertViewController * _Nonnull (UIImage * _Nullable topImage) {
        self.model.topImage = topImage;
        return self;
    };
}

- (PROAlertViewController * _Nonnull (^)(NSURL * _Nullable))topImageURL {
    return ^PROAlertViewController * _Nonnull (NSURL * _Nullable topImageURL) {
        self.model.topImageURL = topImageURL;
        return self;
    };
}

- (PROAlertViewController * _Nonnull (^)(NSString * _Nullable))alertTitle {
    return ^PROAlertViewController * _Nonnull (NSString * _Nullable alertTitle) {
        self.model.title = alertTitle;
        return self;
    };
}

- (PROAlertViewController * _Nonnull (^)(NSString * _Nullable))titleTextColor {
    return ^PROAlertViewController * _Nonnull (NSString * _Nullable titleTextColor) {
        self.model.titleTextColor = titleTextColor;
        return self;
    };
}

- (PROAlertViewController * _Nonnull (^)(CGFloat))titleFontSize {
    return ^PROAlertViewController * _Nonnull (CGFloat titleFontSize) {
        self.model.titleFontSize = titleFontSize;
        return self;
    };
}

- (PROAlertViewController * _Nonnull (^)(PROAlertFontWeight))titleFontWeight {
    return ^PROAlertViewController * _Nonnull (NSUInteger titleFontWeight) {
        self.model.titleFontWeight = titleFontWeight;
        return self;
    };
}

- (PROAlertViewController * _Nonnull (^)(NSString * _Nullable))message {
    return ^PROAlertViewController * _Nonnull (NSString * _Nullable message) {
        self.model.message = message;
        return self;
    };
}

- (PROAlertViewController * _Nonnull (^)(NSString * _Nullable))messageTextColor {
    return ^PROAlertViewController * _Nonnull (NSString * _Nullable messageTextColor) {
        self.model.messageTextColor = messageTextColor;
        return self;
    };
}

- (PROAlertViewController * _Nonnull (^)(CGFloat))messageFontSize {
    return ^PROAlertViewController * _Nonnull (CGFloat messageFontSize) {
        self.model.messageFontSize = messageFontSize;
        return self;
    };
}

- (PROAlertViewController * _Nonnull (^)(PROAlertFontWeight))messageFontWeight {
    return ^PROAlertViewController * _Nonnull (NSUInteger messageFontWeight) {
        self.model.messageFontWeight = messageFontWeight;
        return self;
    };
}

- (PROAlertViewController * _Nonnull (^)(NSTextAlignment))messageTextAlignment {
    return ^PROAlertViewController * _Nonnull (NSTextAlignment messageTextAlignment) {
        self.model.messageTextAlignment = messageTextAlignment;
        return self;
    };
}

- (PROAlertViewController * _Nonnull (^)(NSNumber * _Nullable))imageRatio {
    return ^PROAlertViewController * _Nonnull (NSNumber * _Nullable imageRatio) {
        self.model.imageRatio = imageRatio;
        return self;
    };
}

- (PROAlertViewController * _Nonnull (^)(PROAlertLevel))alertLevel {
    return ^PROAlertViewController * _Nonnull (PROAlertLevel  level) {
        self.model.alertLevel = level;
        return self;
    };
}

- (PROAlertViewController * _Nonnull (^)(BOOL))manualDismissAlert {
    return ^PROAlertViewController  * _Nonnull (BOOL  manual) {
        self.model.manualDismissAlert = manual;
        return self;
    };
}

- (PROAlertViewController * _Nonnull (^)(NSString * _Nullable))firstButtonTitle {
    return ^PROAlertViewController * _Nonnull (NSString * _Nullable firstButtonTitle) {
        self.model.firstButtonTitle = firstButtonTitle;
        return self;
    };
}

- (PROAlertViewController * _Nonnull (^)(NSString * _Nullable))secondButtonTitle {
    return ^PROAlertViewController * _Nonnull (NSString * _Nullable secondButtonTitle) {
        self.model.secondButtonTitle = secondButtonTitle;
        return self;
    };
}

- (PROAlertViewController * _Nonnull (^)(void (^ _Nonnull)(id _Nullable)))firstButtonHandler {
    return ^PROAlertViewController * _Nonnull (void (^ _Nonnull handler)(id _Nullable)) {
        self.model.firstButtonHandler = handler;
        return self;
    };
}

- (PROAlertViewController * _Nonnull (^)(void (^ _Nonnull)(id _Nullable)))secondButtonHandler {
    return ^PROAlertViewController * _Nonnull (void (^ _Nonnull handler)(id _Nullable)) {
        self.model.secondButtonHandler = handler;
        return self;
    };
}

- (PROAlertViewController * _Nonnull (^)(void (^ _Nonnull)(void)))backFromBackground {
    return ^PROAlertViewController * _Nonnull (void (^ _Nonnull handler)(void)) {
        self.model.backFromBackground = handler;
        return self;
    };
}

- (PROAlertViewController * _Nonnull (^)(NSArray<PROAlertAction *> * _Nullable))actionArray {
    return ^PROAlertViewController * _Nonnull (NSArray<PROAlertAction *> * _Nullable actionArray) {
        self.model.actionArray = actionArray;
        return self;
    };
}

- (PROAlertViewController * _Nonnull (^)(void (^ _Nonnull)(void)))showHandler {
    return ^PROAlertViewController * _Nonnull (void (^ _Nonnull handler)(void)) {
        self.model.showHandler = handler;
        return self;
    };
}

#pragma mark -- alert Pool
- (void)setupAlertPool {
    mweakify(self);
    self.showAlertPoolHandler = ^{
        mstrongify(self);
        if (globalAlertPoolArray.count > 0) {
            PROAlertViewController *currentAlert = [PROAlertViewController currentShowAlertViewController];
            //新的alert的优先级别高于正在显示的alert的优先级别
            if (currentAlert && self.model.alertLevel > currentAlert.model.alertLevel) {
                [PROAlertViewController insertAlertInPoolIndex:0 alert:self];
                [currentAlert dismiss:NO];
                [PROAlertViewController insertAlertInPoolIndex:1 alert:currentAlert];
                return ;
            }
            //有正在显示的，新来的alert优先级别太低，直接加入alert队列池，等待显示
            if (currentAlert &&  self.model.alertLevel <= currentAlert.model.alertLevel) {
                [PROAlertViewController addAlertViewInPool:self];
                return;
            }
        }
        
        [self showAlert];
        [PROAlertViewController addAlertViewInPool:self];
    };
}

//Pool根据有限级别进行排序
+ (void)sortPool {
    //重新根据优先级别排序
    [globalAlertPoolArray sortUsingComparator:^NSComparisonResult(PROAlertViewController *alertA, PROAlertViewController *alertB) {
        if (alertA.model.alertLevel < alertB.model.alertLevel) {
            return NSOrderedDescending;
        }
        return NSOrderedAscending;
    }];
}


/**
 加入alert到Pool中

 @param alertViewController 待显示的alert
 */
+ (void)addAlertViewInPool:(PROAlertViewController *)alertViewController {
    NSParameterAssert(alertViewController);
    if (globalAlertPoolArray == nil) {
        globalAlertPoolArray = [NSMutableArray arrayWithCapacity:1];
    }

    //如果alertViewController 不存在
    if (![self alertIsExistedInPool:alertViewController]) {
        [globalAlertPoolArray addObject:alertViewController];
        [self sortPool];
    }
}


/**
 出入alert在指定位置

 @param index 索引
 @param alertViewController 待显示的alert
 */
+ (void)insertAlertInPoolIndex:(NSInteger)index alert:(PROAlertViewController *)alertViewController  {
    NSParameterAssert(alertViewController);
    if (globalAlertPoolArray == nil) {
        globalAlertPoolArray = [NSMutableArray arrayWithCapacity:1];
    }
    if (![self alertIsExistedInPool:alertViewController]) {
        [globalAlertPoolArray safeInsertObject:alertViewController atIndex:index];
        [self sortPool];
    }
}



/**
 移除alert从pool中

 @param alert alert
 */
+ (void)removeAlertViewFromPool:(PROAlertViewController *)alert {
    NSParameterAssert(alert);
    [globalAlertPoolArray removeObject:alert];
}


/**
 继续显示Plool中的alert
 */
+ (void)continueShowAlertFromPool {
    PROAlertViewController *nextAlert = [PROAlertViewController nextShowAlertViewController];
    if (nextAlert) {
        nextAlert.show();
    }
}


/**
 下一个即将要显示的alert

 @return PROAlertViewController
 */
+ (PROAlertViewController *)nextShowAlertViewController {
    __block PROAlertViewController *alert = nil;
    [globalAlertPoolArray enumerateObjectsUsingBlock:^(PROAlertViewController  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!obj.model.show) {
            alert = obj;
        }
        *stop = YES;
    }];
    return alert;
}



/**
 当前d显示的alert

 @return PROAlertViewController
 */
+ (PROAlertViewController *)currentShowAlertViewController {
    __block PROAlertViewController *alert = nil;
    [globalAlertPoolArray enumerateObjectsUsingBlock:^(PROAlertViewController  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.model.show) {
            alert = obj;
        }
        *stop = YES;
    }];
    return alert;
}


/**
 alert是否在pool中已经存在

 @param alert 是否存在
 @return YES or NO
 */
+ (BOOL)alertIsExistedInPool:(PROAlertViewController *)alert {
    __block PROAlertViewController *currentAlert = alert;
    __block BOOL existed = NO;
    [globalAlertPoolArray enumerateObjectsUsingBlock:^(PROAlertViewController  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj == currentAlert) {
            existed = YES;
            *stop = YES;
        }
    }];
    return existed;
}


/**
 清除POOL中所有的alert
 */
+ (void)clearAlertPool {
    [globalAlertPoolArray removeAllObjects];
}
@end
