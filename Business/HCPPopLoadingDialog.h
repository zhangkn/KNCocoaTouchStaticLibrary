//
//  PopLoadingDialog.h
//  HappyMedicalCare
//
//

#import <UIKit/UIKit.h>

//#import "HebaoProgress.h"
#import "HCPCMPayProgress.h"
//#import "Constant.h"


@interface HCPPopLoadingDialog : UIWindow
{
    BOOL closed;
}

@property (nonatomic, retain)UIView *superView;
@property (nonatomic, retain)UIView *backgroundView;
@property (nonatomic, retain)UIImageView *backgroundImage;
@property (nonatomic, retain)UIView *contentView;
@property (nonatomic, retain) UIActivityIndicatorView * indicatorView;

@property (nonatomic, retain) HCPCMPayProgress *cmpayProgress;

//+(void)show;
+(void)show;
+(void)dismiss;
+(BOOL)isShown;

@end
