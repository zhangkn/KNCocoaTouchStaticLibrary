//
//
//  Created by devzkn on 03/11/2016.
//

#import "PicDataModel.h"

@implementation PicDataModel

+ (instancetype)picDataModelWithPicData:(NSData *)picData filename:(NSString *)filename{
    PicDataModel *tmp = [[self alloc]initWithPicData:picData filename:filename];
    return tmp;
}

- (instancetype)initWithPicData:(NSData *)picData filename:(NSString *)filename{
    self = [super init];
    if (self) {
        self.picData = picData;
        self.filename =filename;
    }
    return self;
}

@end
