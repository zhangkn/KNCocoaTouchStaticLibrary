//
//
//  Created by devzkn on 03/11/2016.
//

#import <Foundation/Foundation.h>

@interface PicDataModel : NSObject

@property (nonatomic,copy) NSData *picData;
@property (nonatomic,strong) NSString *filename;

//定义初始化方法 KVC的使用
- (instancetype) initWithPicData:(NSData *) picData filename:(NSString*)filename;
+ (instancetype) picDataModelWithPicData:(NSData *) picData filename:(NSString*)filename;

@end
