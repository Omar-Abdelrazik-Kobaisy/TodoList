//
//  ItemdetailsVC.h
//  TodoList
//
//  Created by Omar on 17/01/2023.
//

#import <UIKit/UIKit.h>
#import "Todoitem.h"
NS_ASSUME_NONNULL_BEGIN

@interface ItemdetailsVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *name_textf;
@property (weak, nonatomic) IBOutlet UITextField *desc_textf;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priority_textf;

@property (weak, nonatomic) IBOutlet UISegmentedControl *state;

@property Todoitem *todoitem;
@property NSInteger index;


-(void)saveArrayOfObjectToUserDefaults:(NSString*) key :(NSMutableArray*) arr;
-(NSMutableArray*)retrievArrayOfObjFromUserDefaultsForLowPriortyArray:(NSString*)key ;
-(NSMutableArray*)retrievArrayOfObjFromUserDefaultsForMidPriortyArray:(NSString*)key ;
-(NSMutableArray*)retrievArrayOfObjFromUserDefaultsForHigPriortyArray:(NSString*)key;
-(NSMutableArray*)retrievArrayOfObjFromUserDefaultsForInprogressArray:(NSString*)key ;
-(NSMutableArray*)retrievArrayOfObjFromUserDefaultsForDoneArray:(NSString*)key ;

//@property NSString* name;
//@property NSString* desc;
//@property NSString* state;
//@property NSString* priority;
//@property NSNumber* priority_index;
@end

NS_ASSUME_NONNULL_END
