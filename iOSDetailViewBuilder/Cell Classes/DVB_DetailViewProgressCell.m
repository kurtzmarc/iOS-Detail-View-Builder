//
//  Copyright 2013 Kurtz Consulting Services LLC.
//

#import "DVB_DetailViewProgressCell.h"

@implementation DVB_DetailViewProgressCell

- (id)initWithLabel:(NSString *) labelString
    withDataManager:(DVB_DetailViewDataManager*) dataManager
            withKey:(NSString*) key
     withController:(UITableViewController*) controller
        withBuilder:(DVB_DetailViewBuilder*) builder
{
    self = [super initWithLabel:labelString withDataManager:dataManager withKey:key withController:controller withBuilder:builder];
    if (self) {
        //
    }
    return self;
}

- (NSString*)cellIdentifier
{
    return @"BuilderProgressCell";
}

- (UITableViewCell*) createCell
{
    UITableViewCell* cell;
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    UIActivityIndicatorView* activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityIndicator startAnimating];
    cell.accessoryView = activityIndicator;
    return cell;
}

- (void) configureCell:(UITableViewCell*) cell
{
    cell.textLabel.text = self.label;
    [super configureCell:cell];
}

- (void) requestEndEditing
{
    // Do nothing...
}

@end
