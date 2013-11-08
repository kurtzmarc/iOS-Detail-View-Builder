//
//  Copyright 2013 Kurtz Consulting Services LLC.
//

#import <Foundation/Foundation.h>
#import "DVB_DetailViewDataManager.h"

@interface DVB_DetailViewSingleValueDataManager : DVB_DetailViewDataManager

@property (nonatomic,strong) NSObject* object;

- (id)initWithInitialValue:(NSObject *) object;

@end
