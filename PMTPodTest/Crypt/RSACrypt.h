//
//  RSACrypt.h
//  TCiPhone_CIMB
//
//  Created by Don Lee on 1/15/13.
//
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>
#import "Base64.h"
#import "BasicEncodingRules.h"

@interface RSACrypt : NSObject

+ (NSData *)generatePublicKeyBits:(BOOL)isCert withCertContent:(NSString *)certContent orWithModulus:(NSString *)modulus andExponent:(NSString *)exponent;
+ (NSData *)encryptToData:(NSString *)plainText withPublicKeyBits:(NSData *)publicKeyBits andTag:(NSString *)tag;
+ (NSString *)encryptAndB64EncodeToStr:(NSString *)plainText withPublicKeyBits:(NSData *)publicKeyBits andTag:(NSString *)tag;
+ (NSData *)getX509PublicKeyBits:(NSString *)certContent;
+ (SecKeyRef)addPublicKeyRef:(NSData *)publicKeyBits withTag:(NSString *)tag;
+ (SecKeyRef)getKeyRefWithPersistentKeyRef:(CFTypeRef)persistentRef;
+ (SecKeyRef)getKeyRefWithTag:(NSString *)tag;
+ (void)removeKeyRefWithTag:(NSString *)tag;

@end
