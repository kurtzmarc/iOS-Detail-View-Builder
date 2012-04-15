//
//  CoreDataDemoController.h
//  iOSDetailViewBuilder
//
//  Created by Marc Kurtz on 1/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDetailViewController.h"

@class Person;

@interface CoreDataDemoController : BaseDetailViewController

@property (nonatomic, strong) Person* person;

@end
