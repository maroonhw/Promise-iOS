//
//  PROBookUserInfoViewController.m
//  Promise
//
//  Created by Hongwei Liu on 2021/4/11.
//

#import "PROBookUserInfoViewController.h"
#import "PROTitleTextField.h"
#import "PRODotSelectView.h"
#import "PROBookUserInfoViewModel.h"
#import "PROCusButton.h"
#import "PROAvatarView.h"
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <PhotosUI/PhotosUI.h>

static NSString * _Nullable const PROPhotoAlbumErrorDomain = @"PROPhotoAlbumErrorDomain";

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_CURRENT_VERSION
@interface PROBookUserInfoViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, PHPickerViewControllerDelegate>
#else
@interface PROBookUserInfoViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
#endif

@property(nonatomic, strong) PROTitleTextField *nameTextField;

@property(nonatomic, strong) PROTitleTextField *emailTextField;

@property(nonatomic, strong) PRODotSelectView *selectView;

@property(nonatomic, strong) PROAvatarView *avatarView;

@property(nonatomic, strong) PROCusButton *jumpButton;

@property(nonatomic, strong) PROCusButton *doneButton;

@property(nonatomic, strong) PROBookUserInfoViewModel *viewModel;

@end

@implementation PROBookUserInfoViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pageTitle = @"完善信息";
        self.needBackButton = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
}

- (void)setupView {
    self.view.backgroundColor = MCOLOR(@"#44606b");
    [self.view addSubview:self.nameTextField];
    [self.view addSubview:self.selectView];
    [self.view addSubview:self.emailTextField];
    [self.view addSubview:self.jumpButton];
    [self.view addSubview:self.doneButton];
    [self.view addSubview:self.avatarView];
    
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(MTopBarHeight + 32);
        make.right.mas_equalTo(-28);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(110);
    }];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(MTopBarHeight + 32);
        make.left.mas_equalTo(28);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(MScreenWidth / 2.5);
    }];
    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameTextField.mas_bottom).offset(48);
        make.left.mas_equalTo(28);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(MScreenWidth / 2.5);
    }];
    [self.emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.selectView.mas_bottom).offset(48);
        make.left.mas_equalTo(28);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(MScreenWidth / 2.5);
    }];
    
    [self.jumpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailTextField.mas_bottom).offset(110);
        make.left.mas_equalTo(28);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(105);
    }];
    
    [self.doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailTextField.mas_bottom).offset(110);
        make.right.mas_equalTo(-28);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(105);
    }];
}

- (void)nameTextFieldDidChange:(NSString *)text {
    self.viewModel.name = text;
}

- (void)emailTextFieldDidChange:(NSString *)text {
    self.viewModel.email = text;
    [self updateButtonStatus];
}

- (void)jumpAction {
    
}

- (void)doneAction {
    
}

- (void)updateButtonStatus {
    BOOL enabled = NO;
    if (!NULLString(self.viewModel.email) && !NULLString(self.viewModel.email)) {
        enabled = YES;
    }
    [self.doneButton updateCusButtonStatus:enabled];
}


- (void)selectPhotoAction {
    mweakify(self)
    [self requestPhotoAuthorization:^(BOOL granted, NSError * _Nullable error) {
        mstrongify(self)
        //相册权限被拒
        if (!granted) {
            [self performInSafeMainThread:^{
                [PROAlertViewController new].
                alertTitle(@"无相册访问权限").
                message(@"无相册访问权限，请在系统设置中修改权限").
                firstButtonTitle(@"退出").
                secondButtonTitle(@"设置").secondButtonHandler(^(id  _Nullable sender) {
                    NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([[UIApplication sharedApplication] canOpenURL:settingsURL]) {
                        [[UIApplication sharedApplication] openURL:settingsURL options:@{} completionHandler:nil];
                    }
                }).show();
            }];
            
            return;
        }
        [self selectPhotoFromSystem];
    }];
}

- (void)selectPhotoFromSystem {
    //判断硬件是否支持
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        return;
    }
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_CURRENT_VERSION
    if (@available(iOS 14.0, *)) {
        PHPickerConfiguration *configuration = [[PHPickerConfiguration alloc] initWithPhotoLibrary:[PHPhotoLibrary sharedPhotoLibrary]];
        configuration.filter = [PHPickerFilter imagesFilter];;
        configuration.selectionLimit = 1;//只允许选择一张
        PHPickerViewController *picker = [[PHPickerViewController alloc] initWithConfiguration:configuration];
        picker.modalPresentationStyle = UIModalPresentationFullScreen;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
        return;
    }
#endif
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.modalPresentationStyle = UIModalPresentationFullScreen;
    picker.allowsEditing = NO;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - 相册权限
- (void)requestPhotoAuthorization:(void (^_Nullable)(BOOL granted, NSError * _Nullable error))block {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_CURRENT_VERSION
    if (@available(iOS 14.0, *)) {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatusForAccessLevel:PHAccessLevelReadWrite];
        // 相册权限显式被拒
        if (status == PHAuthorizationStatusDenied) {
            block(NO,[NSError errorWithDomain:PROPhotoAlbumErrorDomain code:PROPhotoErrorCode_AlbumAuthorizationDenied userInfo:nil]);
            return;
        }
        // 尚未申请相册权限
        if (status == PHAuthorizationStatusNotDetermined) {
            mweakify(self)
            //申请权限
            [PHPhotoLibrary requestAuthorizationForAccessLevel:PHAccessLevelReadWrite handler:^(PHAuthorizationStatus status) {
                mstrongify(self)
                //用户选择 允许访问所有照片 或者 允许访问部分照片
                if (status == PHAuthorizationStatusAuthorized || status == PHAuthorizationStatusLimited) {
                    [self performInSafeMainThread:^{
                        block(YES,nil);
                    }];
                    return;
                }
            }];
            return;
        }
        block(YES,nil);
        
        return;
    }
#endif

    /* iOS14以下版本 */
    // 相册权限显式被拒
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusDenied) {
        block(NO,[NSError errorWithDomain:PROPhotoAlbumErrorDomain code:PROPhotoErrorCode_AlbumAuthorizationDenied userInfo:nil]);
        return;
    }
    // 尚未申请相册权限
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusNotDetermined) {
        __weak typeof(self) weakSelf = self;
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf performInSafeMainThread:^{
                    block(YES,nil);
                }];
                return;
            }
        }];
        return;
    }
    block(YES,nil);
    
}

#pragma mark -  PHPickerViewControllerDelegate
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_CURRENT_VERSION
- (void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results  API_AVAILABLE(ios(14)) {
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (!results || results.count <= 0) {//未获取照片(直接退出)或者获取失败
        [self performInSafeMainThread:^{
            [PROToastView showToastWithMessage:@"获取相片失败" inView:self.view animation:YES];
        }];
        return;
    }
    PHPickerResult *result = results.firstObject;
    if (![result isKindOfClass:[PHPickerResult class]]) {
        return;
    }
    NSItemProvider *itemProvider = result.itemProvider;
    if (![itemProvider canLoadObjectOfClass:UIImage.class]) {//获取到的资源不是UIImage类型，视为获取失败
        [self performInSafeMainThread:^{
            [PROToastView showToastWithMessage:@"获取相片失败" inView:self.view animation:YES];
        }];
        return;
    }
    mweakify(self)
    [itemProvider loadObjectOfClass:UIImage.class completionHandler:^(__kindof id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
        mstrongify(self)
        //获取到的资源不是UIImage类型，视为获取失败
        if (![object isKindOfClass:UIImage.class]) {
            [self performInSafeMainThread:^{
                [PROToastView showToastWithMessage:@"获取相片失败" inView:self.view animation:YES];
            }];
            return;
        }
        self.viewModel.image = object;
        [self performInSafeMainThread:^{
            self.avatarView.image = self.viewModel.image;
        }];
    }];
}
#endif


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if (![type isEqualToString:(NSString *)kUTTypeImage]) {//读取照片失败
        [self performInSafeMainThread:^{
            [PROToastView showToastWithMessage:@"获取相片失败" inView:self.view animation:YES];
        }];
        return;
    }
    
    self.viewModel.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self performInSafeMainThread:^{
        self.avatarView.image = self.viewModel.image;
    }];
}

- (void)performInSafeMainThread:(void(^)(void))block {
    if (block == nil) {
        return;
    }
    
    if ([NSThread currentThread].isMainThread) {
        block();
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    }
}

- (PROTitleTextField *)nameTextField {
    if (!_nameTextField) {
        _nameTextField = [[PROTitleTextField alloc] initWithTitle:@"昵称" placeholder:@"请输入昵称"];
        mweakify(self)
        _nameTextField.textFieldDidChangeHandler = ^(NSString * _Nonnull text) {
            mstrongify(self)
            [self nameTextFieldDidChange:text];
        };
    }
    return _nameTextField;
}

- (PROTitleTextField *)emailTextField {
    if (!_emailTextField) {
        _emailTextField = [[PROTitleTextField alloc] initWithTitle:@"邮箱" placeholder:@"请输入邮箱"];
        mweakify(self)
        _emailTextField.textFieldDidChangeHandler = ^(NSString * _Nonnull text) {
            mstrongify(self)
            [self emailTextFieldDidChange:text];
        };
    }
    return _emailTextField;
}

- (PRODotSelectView *)selectView {
    if (!_selectView) {
        _selectView = [[PRODotSelectView alloc] init];
        _selectView.title = @"性别";
        _selectView.firstOptionTitle = @"男";
        _selectView.secondOptionTitle = @"女";
    }
    return _selectView;
}

- (PROCusButton *)jumpButton {
    if (!_jumpButton) {
        _jumpButton = [[PROCusButton alloc] init];
        [_jumpButton setTitle:@"跳过" forState:UIControlStateNormal];
        _jumpButton.enabled = YES;
        _jumpButton.style = PROCusButtonStyleHollow;
        [_jumpButton addTarget:self action:@selector(jumpAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jumpButton;
}

- (PROCusButton *)doneButton {
    if (!_doneButton) {
        _doneButton = [[PROCusButton alloc] init];
        [_doneButton setTitle:@"完成" forState:UIControlStateNormal];
        _doneButton.enabled = NO;
        [_doneButton addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}

- (PROAvatarView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[PROAvatarView alloc] init];
        _avatarView.title = @"点击更换头像";
        mweakify(self)
        _avatarView.selectPhotoComplate = ^{
            mstrongify(self)
            [self selectPhotoAction];
        };
    }
    return _avatarView;
}

- (PROBookUserInfoViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PROBookUserInfoViewModel alloc] init];
    }
    return _viewModel;
}

@end
