//
//  AESCrypt.h
//  n2ncontest
//
//  Created by Adrian Lo on 2/21/11.
//  Copyright 2011 The Wabbit Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#define kChosenCipherBlockSize	kCCBlockSizeAES128
#define kChosenCipherKeySize	kCCKeySizeAES128
#define kChosenDigestLength		CC_SHA1_DIGEST_LENGTH

@interface AESCrypt : NSObject {
    
}
+ (NSData *) EncryptString:(NSString *)plainSourceStringToEncrypt withKey:(NSString *) key;
- (NSData *)encrypt:(NSData *)plainText key:(NSData *)aSymmetricKey padding:(CCOptions *)pkcs7;
- (NSData *)doCipher:(NSData *)plainText key:(NSData *)aSymmetricKey
			 context:(CCOperation)encryptOrDecrypt padding:(CCOptions *)pkcs7;

- (NSData*) md5data: ( NSString *) str;

@end
