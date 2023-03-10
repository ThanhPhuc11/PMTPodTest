//
//  RSAClass.h
//  PMTPodTest
//
//  Created by PhucMT on 09/03/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSAClass : NSObject

- (NSString *)rsaEncryptData:(NSString *)plainText withModulus:(NSString *)modulus andExponent:(NSString *)exponent andTag:(NSString *)tag;

+ (nullable NSString *)encryptedPassword:(NSString *)password publicKey:(NSString *)publicKey randomNum:(NSString *)randomNum sessionID:(NSString *)sessionID;

@end

NS_ASSUME_NONNULL_END
