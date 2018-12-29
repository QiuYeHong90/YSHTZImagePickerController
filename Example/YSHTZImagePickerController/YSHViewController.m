//
//  YSHViewController.m
//  YSHTZImagePickerController
//
//  Created by 793983383@qq.com on 12/29/2018.
//  Copyright (c) 2018 793983383@qq.com. All rights reserved.
//

//#import <>
#import <YSHTZImagePickerController/PureCamera.h>
#import <YSHTZImagePickerController/TZImagePickerController.h>
#import "ToolAlert.h"
#import "YSHViewController.h"
//#import "<#header#>"


@interface YSHViewController ()


@property (nonatomic,assign) BOOL isVideo;

@end

@implementation YSHViewController
- (IBAction)selectBtn:(id)sender {
    [self showAlertAboutPhotoOrCamera];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)showAlertAboutPhotoOrCamera
{
    
    __weak typeof(self) weakSelf = self;
    
    
    
    [ToolAlert AlertControllerWithVC:self title:nil message:nil style:UIAlertControllerStyleActionSheet callBlock:^(NSInteger tag) {
        weakSelf.isVideo = NO;
        if (tag==0) {
            [weakSelf takePhoto];
        }else if (tag==1){
            [weakSelf pushTZImagePickerController];
        }else{
            weakSelf.isVideo = YES;
            [weakSelf pushTZImagePickerController];
        }
    } confirmButtonTitle:nil cancelButtonTitle:NSLocalizedString(@"取消", nil) otherButtonTitlesArray:@[NSLocalizedString(@"拍摄", nil),NSLocalizedString(@"选择图片", nil),NSLocalizedString(@"选择视频", nil)]];
    
}

-(void)takePhoto
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)) {
        
        NSDictionary *infoDict = [TZCommonTools tz_getInfoDictionary];
        // 无权限 做一个友好的提示
        NSString *appName = [infoDict valueForKey:@"CFBundleDisplayName"];
        if (!appName) appName = [infoDict valueForKey:@"CFBundleName"];
        
        NSString *message = [NSString stringWithFormat:[NSBundle tz_localizedStringForKey:@"Please allow %@ to access your camera in \"Settings -> Privacy -> Camera\""],appName];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSBundle tz_localizedStringForKey:@"Can not use camera"] message:message delegate:self cancelButtonTitle:[NSBundle tz_localizedStringForKey:@"Cancel"] otherButtonTitles:[NSBundle tz_localizedStringForKey:@"Setting"], nil];
        [alert show];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                        PureCamera *homec = [[PureCamera alloc] init];
                        homec.ratio = TOCropViewControllerAspectRatioSquare;
                        __weak typeof(self) myself = self;
                        homec.fininshcapture = ^(UIImage *ss) {
                            if (ss) {
                                
                                NSLog(@"==%@",ss);
                                
                                
                                
                                
                                [self UploadImage:ss];
                                
                                
                            }
                        };
                        [myself presentViewController:homec
                                             animated:NO
                                           completion:^{
                                           }];
                    } else {
                        
                    }
                });
            }
        }];
    } else {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            PureCamera *homec = [[PureCamera alloc] init];
            homec.ratio = TOCropViewControllerAspectRatioSquare;
            __weak typeof(self) myself = self;
            homec.fininshcapture = ^(UIImage *ss) {
                if (ss) {
                    
                    NSLog(@"==%@",ss);
                    
                    
                    
                    
                    [self UploadImage:ss];
                    
                    
                }
            };
            [myself presentViewController:homec
                                 animated:NO
                               completion:^{
                               }];
        } else {
            
        }
    }
}

#pragma mark - TZImagePickerController

- (void)pushTZImagePickerController {
    
    
    
    
    NSInteger imgCount = 1;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:imgCount delegate:self pushPhotoPickerVc:YES];
    
    imagePickerVc.allowCrop = NO;
    // imagePickerVc.navigationBar.translucent = NO;
    
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = NO;
    
    if (imgCount > 1) {
        // 1.设置目前已经选中的图片数组
        //        imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    }
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    
    // imagePickerVc.photoWidth = 1000;
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    //    imagePickerVc.navigationBar.barTintColor = [UIColor colorWithHexString:mainColor];
    imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    imagePickerVc.oKButtonTitleColorNormal = UIColor.greenColor;
    imagePickerVc.navigationBar.translucent = NO;
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.ratio = TOCropViewControllerAspectRatioNone;
    if (self.isVideo) {
        imagePickerVc.allowPickingVideo = YES;
        imagePickerVc.allowPickingImage = NO;
        imagePickerVc.allowPreview = YES;
        
    }else{
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.allowPickingImage = YES;
        imagePickerVc.allowPreview = NO;
    }
    
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingGif = YES;
    imagePickerVc.allowPickingMultipleVideo =NO; // 是否可以多选视频
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
    
    /// 5. Single selection mode, valid when maxImagesCount = 1
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = NO;
    imagePickerVc.needCircleCrop = NO;
    // 设置竖屏下的裁剪尺寸
    //    NSInteger left = 30;
    //    NSInteger widthHeight = self.view.tz_width - 2 * left;
    //    NSInteger top = (self.view.tz_height - widthHeight) / 2;
    //    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    // 设置横屏下的裁剪尺寸
    // imagePickerVc.cropRectLandscape = CGRectMake((self.view.tz_height - widthHeight) / 2, left, widthHeight, widthHeight);
    /*
     [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
     cropView.layer.borderColor = [UIColor redColor].CGColor;
     cropView.layer.borderWidth = 2.0;
     }];*/
    
    
    // 自定义导航栏上的返回按钮
    /*
     [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton){
     [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
     [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 20)];
     }];
     imagePickerVc.delegate = self;
     */
    
    imagePickerVc.isStatusBarDefault = NO;
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    __weak typeof(self) weakSelf = self;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            NSLog(@"图片");
        }];
    
    imagePickerVc.fininshcapture = ^(UIImage *image) {
       
    };
    
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}






// Decide album show or not't
// 决定相册显示与否
- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(id)result {
    
    if ([albumName isEqualToString:NSLocalizedString(@"个人收藏", nil)]) {
        return NO;
    }
    if ([albumName isEqualToString:NSLocalizedString(@"视频", nil)]) {
        return YES;
    }
    return YES;
}

// Decide asset show or not't
// 决定asset显示与否
- (BOOL)isAssetCanSelect:(PHAsset *)asset {
    
    switch (asset.mediaType) {
        case PHAssetMediaTypeVideo: {
            // 视频时长
            // NSTimeInterval duration = phAsset.duration;
            return YES;
        } break;
        case PHAssetMediaTypeImage: {
            // 图片尺寸
            //     if (asset.pixelWidth > 3000 || asset.pixelHeight > 3000) {
            //      return NO;
            //     }
            return YES;
        } break;
        case PHAssetMediaTypeAudio:
            return NO;
            break;
        case PHAssetMediaTypeUnknown:
            return NO;
            break;
        default: break;
    }
    
    return YES;
}






-(void)UploadImage:(UIImage *)image
{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
