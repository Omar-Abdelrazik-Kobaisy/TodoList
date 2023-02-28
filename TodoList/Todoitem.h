//
//  Todoitem.h
//  TodoList
//
//  Created by Omar on 17/01/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Todoitem : NSObject<NSCoding>

@property NSString *name;
@property NSString *desc;
@property NSString *date;
//@property NSString *priority;
//@property NSNumber *priority_index;
@property NSNumber *priortyTask;
@property NSNumber *state;
@end

NS_ASSUME_NONNULL_END
