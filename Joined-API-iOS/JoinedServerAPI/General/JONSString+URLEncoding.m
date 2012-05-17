//
//  NSString+URLEncoding.m
//  Joined
//
//  Created by Henning Kettler on 4/4/12.
//  Copyright (c) 2012 GeoMobile GmbH. All rights reserved.
//

#import "JONSString+URLEncoding.h"

@implementation NSString (URLEncoding)
- (NSString *)urlEncode {
    NSMutableString *result;
    
    //Leerzeichen vorne und hinten entfernen
    result = [NSMutableString stringWithString:[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    
    //Die anderen Leerzeichen encoden
    [result replaceOccurrencesOfString:@" " withString:@"%20" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    
    // Ä und ä ersetzen
    [result replaceOccurrencesOfString:@"Ä" withString:@"%C4" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"ä" withString:@"%E4" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    
    //Ö und ö
    [result replaceOccurrencesOfString:@"Ö" withString:@"%D6" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"ö" withString:@"%F6" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    
    //Ü und ü
    [result replaceOccurrencesOfString:@"Ü" withString:@"%DC" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"ü" withString:@"%FC" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    
    //ß ersetzen
    [result replaceOccurrencesOfString:@"ß" withString:@"%DF" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    
    return result;
}

@end
