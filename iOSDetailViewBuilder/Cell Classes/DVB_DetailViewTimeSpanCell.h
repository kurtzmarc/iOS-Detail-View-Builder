//
//  DVB_DetailViewDateCell.h
//  Face Charts
//
//  Created by Marc Kurtz on 7/30/11.
//  Copyright 2011 Kurtz Consulting Services LLC. All rights reserved.
//

#import "DetailViewItem.h"

@interface DetailViewTimeSpanCell : DetailViewItem<UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIPopoverControllerDelegate>{
    @private
    int _contentOffsetY;
}

@property (nonatomic, strong) UIPopoverController* popoverController;
@property (nonatomic, strong) UIActionSheet* actionSheet;
@property (nonatomic, strong) UIPickerView* picker;

- (id)initWithLabel:(NSString *) labelString
    withDataManager:(DetailViewDataManager*) dataManager
            withKey:(NSString*) key
     withController:(UITableViewController*) controller
        withBuilder:(DetailViewBuilder*) builder;

-(IBAction)timeSpanPickerDoneClick;

+(NSDate*) addTimeIntervalToDate:(NSDate*)date;

@end
