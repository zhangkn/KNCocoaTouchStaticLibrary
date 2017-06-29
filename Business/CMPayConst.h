//
//  CMPayConst.h
//  iPosLib
//
//  Created by devzkn on 10/01/2017.
//  Copyright © 2017 Hisun. All rights reserved.
//
#import <Foundation/Foundation.h>

#define weakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

/** 生产环境  https://tsm.cmpay.com/static/mocam_pro/index.html */
extern   NSString *const PRODUCTIONBaseURL;
/** 预投产环境
*/
extern   NSString *const PREBaseURL ;
/** /UAT测试环境 */

extern   NSString *const UATBaseURL;
/** SIT内网测试环境 */
extern   NSString *const SITINTRANETBaseURL ;

extern   NSString *const SITEXTRANETBaseURL ;



