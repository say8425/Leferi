//
//  NSDictionary+JSONCategories.h
//  Leferi
//
//  Created by Cheon Park on 2014. 10. 15..
//  Copyright (c) 2014년 northPenguin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSONCategories)

+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress;
-(NSData*)toJSON;

@end
