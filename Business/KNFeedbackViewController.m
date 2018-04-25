//
//

#import "KNFeedbackViewController.h"
#import "Const.h"
#import "UIView+Extension.h"
#import "HWComposePhotosView.h"
//#import "NSMutableURLRequestTool.h"
#import "sys/utsname.h"
#import <AssetsLibrary/AssetsLibrary.h>

#import "PicDataModel.h"
#import "Const.h"

@interface KNFeedbackViewController ()<UITextViewDelegate,UIScrollViewDelegate,UITableViewDelegate,HWComposePhotosViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate>

/** 用户是否选择了上传图片 ，用于判断是否调用上传图片接口，还是直接调用ics平台后台接口*/
@property (nonatomic,assign) BOOL hasComposePhotos;

@property (nonatomic,strong) NSArray *composePhotos;

/** 输入控件*/
@property (nonatomic,weak) HWPlaceholderTextView *textView;

/** 显示字数的控件*/
@property (nonatomic,weak) KNUILabel *textCountLabel;

/** textView 是否有内容*/
@property (nonatomic,assign) BOOL isTextViewHasChar;
/** 显示从相册选择的image或者拍照的照片 的视图*/
@property (nonatomic,strong) HWComposePhotosView *composePhotosView;


@end

@implementation KNFeedbackViewController

#define KNMargin 8
- (HWPlaceholderTextView *)textView{
    if (nil == _textView) {
        NSString *textViewPalceHolder =  @"请描述你的问题?";
        HWPlaceholderTextView *tmpView = [HWPlaceholderTextView placeholderTextViewWithTextViewPalceHolder:textViewPalceHolder];
        _textView = tmpView;
        tmpView.backgroundColor = KNColor(255, 255, 255);
        CGFloat x = KNMargin;
        CGFloat w = KMainScreenWidth-(2*KNMargin) ;
        tmpView.frame = CGRectMake(x, 16,w ,150);
        tmpView.font = HWTextViewFont;
        tmpView.textViewPalceHolderColor = [UIColor grayColor];
        tmpView.layer.cornerRadius = 8;
        [self.view addSubview:_textView];
    }
    return _textView;
}


- (void)awakeFromNib{
    [super awakeFromNib];
}

- (UILabel *)textCountLabel{
    if (nil == _textCountLabel) {
        UILabel *tmpView = [[KNUILabel alloc]init];
        _textCountLabel = tmpView;
        tmpView.textColor = KNFeedBackColor;
        tmpView.font = [UIFont systemFontOfSize:11];
        [self.view addSubview:_textCountLabel];
    }
    return _textCountLabel;
}

#pragma mark - 布局子控件的frame
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.textCountLabel.KNWidth = 25;
    self.textCountLabel.KNHeight = self.textCountLabel.font.lineHeight;
    self.textCountLabel.KNX = KMainScreenWidth-self.textCountLabel.KNWidth-15;
    self.textCountLabel.KNY = CGRectGetMaxY(self.textView.frame)+6;
    //布局composePhotosView
    self.composePhotosView.KNX = 7;
    self.composePhotosView.KNY = CGRectGetMaxY(self.textCountLabel.frame)+6;
    self.composePhotosView.KNWidth = self.view.frame.size.width - self.composePhotosView.KNX*2;
    self.composePhotosView.KNHeight = self.view.frame.size.height;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈问题";
    self.view.backgroundColor =KNColor(245, 245, 245);
    //设置输入控件
    [self setupTextView];
    [self setupTextCountLabel];
    //构建显示相册图片的视图
    [self setupComposePhotosView];
    
}

- (void)back {
    [self.view endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)actionNavBackFeed{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (HWComposePhotosView *)composePhotosView{
    if (nil == _composePhotosView) {
        HWComposePhotosView *tmp = [[HWComposePhotosView alloc]init];
        _composePhotosView = tmp;
//        tmp.backgroundColor = [UIColor redColor];
        [self.view addSubview:_composePhotosView];
    }
    return _composePhotosView;
}

- (void)setupComposePhotosView{
    [self.composePhotosView setDelegate:self];
    if (self.image) {
        [self.composePhotosView addPhoto:self.image];
    }
}

- (void)setupTextCountLabel{
    //计算textView的字数
    [self updateTextCountLabel];
}

- (void)updateTextCountLabel{
    unsigned long num ;
    if (self.textView.text.length>=240) {
         num = 0;
    }else{
        num =(unsigned long)(240 - self.textView.text.length);
    }
     self.textCountLabel.text = [NSString stringWithFormat:@"%lu",num];

}

- (void)setupTextView{
    [self.textView setDelegate:self];
    [self.textView becomeFirstResponder];
    if (self.textView.text.length == 0 || self.textView.text == nil) {
        self.isTextViewHasChar = NO;
    }else{
        self.isTextViewHasChar = YES;
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //Dragging 的时候关闭键盘
    [self.view endEditing:YES];
}



- (void)userDidTakeScreenshot:(NSNotification *)notification{
    //重写截屏响应方法。本页面不响应
    NSLog(@"%s",__func__);
}

/** 此方法只有用户点击return才可以触发*/
- (void)textViewDidEndEditing:(UITextView *)textView{
    [self.textView resignFirstResponder];
    //第一次按return键并不会调用textViewDidChange，因此在一次判断长度
    if (textView.text.length>0) {
        self.isTextViewHasChar = YES;
    }else{
        self.isTextViewHasChar = NO;
    }
}

/** 控制字数、以及自动增加textView 的height*/
/**
 The current selection range. If the length of the range is 0, range reflects the current insertion point. If the user presses the Delete key, the length of the range is 1 and an empty string object replaces that single character.
 */
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *strText = textView.text;//替换前的文字
    /** 隐藏占位字符串的逻辑移到自定义textview内部实现*/
    //    NSLog(@"------- text: %@    strText:%@   range.length: %lu   location: %lu ",text,strText,(unsigned long)range.length,range.location);
    //
    //    if (strText.length == 0 &&
    //        [text isEqualToString:@""])
    //        self.textView.hiddentextViewPalceHolder = NO;
    //    else if (strText.length == 1 &&             [text isEqualToString:@""]){//处理删除键的情况
    //        self.textView.hiddentextViewPalceHolder = NO;
    //    }else
    //        self.textView.hiddentextViewPalceHolder = YES;
    //
    //1.控制发送按钮状态
    [self processSendComposeButtonState:strText replacementText:text];
    
    //2.控制composePhotosView的位置
    
//    NSLog(@"打印字数＝＝%lu",(unsigned long)textView.text.length );
//    double numLines = textView.contentSize.height/textView.font.lineHeight;
//    NSLog(@"numlines = %f", numLines);
//    // 计算出长宽1
//    CGSize size = [[strText stringByAppendingString:text] sizeWithFont:self.textView.font maxW:textView.frame.size.width-10];
//    CGFloat margin = size.height +textView.font.lineHeight*2;
//    if (self.composePhotosView.y - margin <= 0 ) {
//        self.composePhotosView.y = margin;
//    }
    
    
    if ([text isEqualToString:@""]) {
        return YES;
    }
    
    //3. 控制字数
//    int nTotalHasText = [self convertToInt:strText];// 原来字符串的字符个数
    NSUInteger nTotalHasText = strText.length;// 原来字符串的字符个数
    // 计算新字符串的字符个数
    NSUInteger nTotalToLoadText = text.length;
    
    
    /** 按键盘的return按钮，textview 失去焦点*/
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return false;
    }
    else if(nTotalHasText >= 240 && nTotalToLoadText > 0)    {//控制字数为240
        return false;
    }
    return YES;
    
}

- (void)textViewDidChange:(UITextView *)textView{
    [self updateTextCountLabel];
    if (textView.text.length>0) {
        self.isTextViewHasChar = YES;
    }else{
        self.isTextViewHasChar = NO;
    }
}

/** 计算字符串中NSUnicodeStringEncoding 编码的字符个数*/
-  (int)convertToInt:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++)
    {
        if (*p)
        {
            p++;
            strlength++;
        }
        else
        {
            p++;
        }
    }
    return strlength;
    
}


/**控制发送按钮状态 */
- (BOOL)processSendComposeButtonState:(NSString* )strText replacementText:text{
    
    if (strText.length == 0 &&        [text isEqualToString:@""]){
        self.isTextViewHasChar=   NO;
    }else if (strText.length == 1 &&             [text isEqualToString:@""]){//处理删除键的情况
        self.isTextViewHasChar   =NO;
    }else if(strText.length == 0 && [text isEqualToString:@"\n"]){//第一次按return的时候
        self.isTextViewHasChar   =NO;
    }
    else{
        self.isTextViewHasChar  =YES;
    }
    return self.isTextViewHasChar;
}

#pragma mark - 根据多个控件是否有内容进行控制发送按钮
- (void) processSendComposeButtonState{
    if (self.isTextViewHasChar) {//此条件是： 发送
        NSLog(@"%s",__func__);
        self.composePhotos = [self.composePhotosView getphotos] ;
        self.hasComposePhotos = ([self.composePhotos count]>0);
        if (self.hasComposePhotos) {
            //上传图片、文字信息
            [ self startUpload];
        }else{
            //调用后台接口上送文字
            [self invokeFeedback];
        }
    }else{
        [self ShowSysMessageBox:@"请填写您的意见和建议"];
        
    }
}
- (NSMutableArray*) setuppicdatas{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<self.composePhotos.count; i++) {
        NSData *obj = self.composePhotos[i];
        PicDataModel *model1 = [PicDataModel picDataModelWithPicData:obj filename:[NSString stringWithFormat:@"filename%d.png",i]] ;
        [array addObject:model1];
    }
    return array;
}
- (NSString*)setupPolocy:(NSArray*)array{
    NSError *parseError = nil;
    //将NSMutableDictionary中的数据转化为 json数据
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[self setupPolocyDictionary:array] options:NSJSONWritingPrettyPrinted error:&parseError];
    //将得到的json数据转化为NSString类型
    NSString* rawPolecy = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //用base64对所获得的字符串进行加密
    
    NSLog(@"joson = %@",rawPolecy);
    // 先转化为NSData数据
    NSData *nsdata = [rawPolecy dataUsingEncoding:NSUTF8StringEncoding];
    // 将所获的NSData数据进行base64加密
    NSString *polocy = [nsdata base64EncodedStringWithOptions:0];
    return polocy;
}



- (NSMutableDictionary*)setupPolocyDictionary:(NSArray*)array{
    //将信息写入字典
    NSMutableDictionary* policyMap = [[NSMutableDictionary alloc] init];
    return policyMap;
}


- (NSString*) getFeedbackstrMobileNo{
    NSString *strMobileNo;
    return strMobileNo;
}

#pragma mark 上传图片
- (void) startUpload{
    
}

#pragma mark - alertViewDeleagte


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        //关闭当前页面，放回到上一个页面
        [alertView removeFromSuperview];
        [self back];
    }else{
        return;
    }
}



#pragma mark - 处理请求返回
- (void)processStatusCode:(NSHTTPURLResponse *)urlResponese data:(NSData*)data{
    
}


-(void)RightAction:(UIButton*)btn{
    [self processSendComposeButtonState];
}


#pragma mark -  HWComposePhotosViewDelegate

- (void)composePhotosViewDidClickAddPhoto:(HWComposePhotosView *)composePhotosView{
    [self openUIImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (void)openUIImagePickerController:(UIImagePickerControllerSourceType)type{
    //是否支持
    if (![UIImagePickerController isSourceTypeAvailable:type]) {
        return;
    }
    //控制器跳转
    UIImagePickerController *vc = [[UIImagePickerController alloc]init];
    vc.sourceType = type;
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}


#pragma mark - UIImagePickerControllerDelegate
// The picker does not dismiss itself; the client dismisses it in these callbacks.
// The delegate will receive one or the other, but not both, depending whether the user
// confirms or cancels.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"%@",info);
    //图片格式判断
    
    NSURL *url = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init] ;
    [library assetForURL:url resultBlock:^(ALAsset *asset) {
        ALAssetRepresentation *repr = [asset defaultRepresentation];
        if (!([[repr UTI] isEqualToString:@"public.jpeg"] ||  [[repr UTI] isEqualToString:@"public.png"])) {
            //请选择jpg、png格式的图片
            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"" message:@"请选择jpg、png格式的图片" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [av show];
            [picker dismissViewControllerAnimated:YES completion:nil];
        }else{
            
            //1. 显示图片到self.textView 上面
            UIImage *image = info[UIImagePickerControllerOriginalImage];
            [self.composePhotosView addPhoto:image];
            //2.处理发送按钮状态
            self.hasComposePhotos = [self.composePhotosView hasComposePhotos];
            //3.dismissViewControllerAnimated
            [picker dismissViewControllerAnimated:YES completion:nil];
            
        }
        
    } failureBlock:^(NSError *error) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 调用意见反馈接口
- (void)invokeFeedback
{
    // 组装请求参数
}

@end
