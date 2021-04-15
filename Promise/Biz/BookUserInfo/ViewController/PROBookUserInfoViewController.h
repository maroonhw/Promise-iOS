//
//  PROBookUserInfoViewController.h
//  Promise
//
//  Created by Hongwei Liu on 2021/4/11.
//

#import "PROBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

//读取相册、相机权限相关权限
typedef NS_ENUM(NSUInteger, PROPhotoErrorCode) {
    PROPhotoErrorCode_StatusNotDetermined        = 0,    // 系统还未知是否访问，第一次开启相机时,需要申请系统权限
    PROPhotoErrorCode_StatusRestricted           = 1,    // 相机受限制与PROPhotoErrorCode_StatusDenied可以一起处理
    PROPhotoErrorCode_StatusDenied               = 2,    // 不允许访问相机
    PROPhotoErrorCode_StatusAuthorized           = 3,    // 允许访问相机
    PROPhotoErrorCode_CameraUnavailable          = 4,    // 相机设备不可用
    PROPhotoErrorCode_ScanFailed                 = 5,    // 扫描失败
    PROPhotoErrorCode_SelectFailed               = 6,    // 读取照片失败
    PROPhotoErrorCode_AnalyticalFailed           = 7,    // 解析失败
    PROPhotoErrorCode_AlbumAuthorizationDenied   = 8,    // 相册权限被拒的错误
};

@interface PROBookUserInfoViewController : PROBaseViewController

@end

NS_ASSUME_NONNULL_END
