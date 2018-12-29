/*!
 @abstract

 */
#import <UIKit/UIKit.h>
#import "TOCropViewController.h"
typedef void (^fininshcapture)(UIImage *image);
@interface PureCamera : UIViewController
@property (nonatomic,copy) fininshcapture fininshcapture;
/**
 切图比例
 */
@property (nonatomic,assign) TOCropViewControllerAspectRatio ratio;
@end
