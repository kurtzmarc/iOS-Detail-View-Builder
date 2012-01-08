//
//  Person.h
//  iOSDetailViewBuilder
//
//  Created by Marc Kurtz on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDecimalNumber * birthdate;
@property (nonatomic, retain) NSNumber * birthdatealarm;

@end
