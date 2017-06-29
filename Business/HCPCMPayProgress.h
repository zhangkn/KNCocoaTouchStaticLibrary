//

#import <UIKit/UIKit.h>

@interface HCPCMPayProgress : UIView


//**第一个点*/
@property (weak, nonatomic) IBOutlet UIImageView *image1;
//**第二个点*/
@property (weak, nonatomic) IBOutlet UIImageView *image2;
//**第三个点*/
@property (weak, nonatomic) IBOutlet UIImageView *image3;

-(void)Show;
-(void)Hide;


@end
