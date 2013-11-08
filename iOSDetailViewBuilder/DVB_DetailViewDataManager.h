//
//  Copyright 2013 Kurtz Consulting Services LLC.
//

@class DVB_DetailViewItem;

@interface DVB_DetailViewDataManager : NSObject

-(NSObject *)getValue:(DVB_DetailViewItem*) item;
-(void)setValue:(NSObject *)value forItem:(DVB_DetailViewItem*) item;

@end
