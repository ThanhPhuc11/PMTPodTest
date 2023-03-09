//
//  NSString-Hash.h
//  Crypt
//
//  Created by Don Lee on 12/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>


@interface NSString(Hash)
    
- (NSString *)md5HexDigest;
- (NSString *)sha256HexDigest;

@end
