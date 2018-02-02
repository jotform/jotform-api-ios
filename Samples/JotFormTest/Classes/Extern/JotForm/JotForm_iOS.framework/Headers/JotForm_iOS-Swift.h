// Generated by Apple Swift version 4.0.3 effective-3.2.3 (swiftlang-900.0.74.1 clang-900.0.39.2)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_attribute(external_source_symbol)
# define SWIFT_STRINGIFY(str) #str
# define SWIFT_MODULE_NAMESPACE_PUSH(module_name) _Pragma(SWIFT_STRINGIFY(clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in=module_name, generated_declaration))), apply_to=any(function, enum, objc_interface, objc_category, objc_protocol))))
# define SWIFT_MODULE_NAMESPACE_POP _Pragma("clang attribute pop")
#else
# define SWIFT_MODULE_NAMESPACE_PUSH(module_name)
# define SWIFT_MODULE_NAMESPACE_POP
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR __attribute__((enum_extensibility(open)))
# else
#  define SWIFT_ENUM_ATTR
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_ATTR SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if __has_feature(modules)
@import ObjectiveC;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

SWIFT_MODULE_NAMESPACE_PUSH("JotForm_iOS")

SWIFT_CLASS("_TtC11JotForm_iOS7JotForm")
@interface JotForm : NSObject
- (nonnull instancetype)initWithApiKey:(NSString * _Nonnull)apikey debugMode:(BOOL)debugmode euApi:(BOOL)euApi OBJC_DESIGNATED_INITIALIZER;
- (void)executeGetEUapiWithPath:(NSString * _Nonnull)path onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)createReport:(int64_t)formID reportParams:(NSDictionary<NSString *, id> * _Nonnull)reportParams onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)createSuggestion:(int64_t)formID suggestionParams:(NSDictionary<NSString *, id> * _Nonnull)suggestionParams onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)login:(NSDictionary<NSString *, id> * _Nonnull)userinfo onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)logout:(NSDictionary<NSString *, id> * _Nonnull)userinfo onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)registerUser:(NSDictionary<NSString *, id> * _Nonnull)userinfo onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getUser:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getForms:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getForms:(NSInteger)offset limit:(NSInteger)limit orderBy:(NSString * _Nonnull)orderBy filter:(NSDictionary<NSString *, id> * _Nullable)filter onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getSubmissions:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getSubmissions:(NSInteger)offset limit:(NSInteger)limit orderBy:(NSString * _Nonnull)orderBy filter:(NSDictionary<NSString *, id> * _Nullable)filter onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getSubusers:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getFolders:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getFolder:(int64_t)folderID onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getReports:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)deleteReport:(int64_t)reportID onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getSettings:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)updateSettings:(NSDictionary<NSString *, id> * _Nonnull)settings onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getHistory:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getHistory:(NSString * _Nonnull)action date:(NSString * _Nonnull)date sortBy:(NSString * _Nonnull)sortBy startDate:(NSString * _Nonnull)startDate endDate:(NSString * _Nonnull)endDate onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getForm:(int64_t)formID onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getFormQuestions:(int64_t)formID onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getFormQuestion:(int64_t)formID questionID:(int64_t)qid onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getFormSubmissions:(int64_t)formID onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getFormSubmissions:(int64_t)formID offset:(NSInteger)offset limit:(NSInteger)limit orderBy:(NSString * _Nonnull)orderBy filter:(NSDictionary<NSString *, id> * _Nonnull)filter onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getFormReports:(int64_t)formID onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)createFormSubmissions:(int64_t)formID submission:(NSDictionary<NSString *, id> * _Nonnull)submission onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getFormFiles:(int64_t)formID onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getFormWebhooks:(int64_t)formID onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)createFormWebhooks:(int64_t)formID hookUrl:(NSString * _Nonnull)webhookURL onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)deleteWebhook:(int64_t)formID webhookId:(int64_t)webhookID onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getSubmission:(int64_t)sid onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getReport:(int64_t)reportID onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)createReport:(int64_t)formID title:(NSString * _Nonnull)title list_type:(NSString * _Nonnull)list_type fields:(NSString * _Nonnull)fields onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getFormProperties:(int64_t)formID onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getFormProperty:(int64_t)formID propertyKey:(NSString * _Nonnull)propertyKey onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)checkEUserver:(NSString * _Nonnull)_apiKey onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)deleteSubmission:(int64_t)sid onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)editSubmission:(int64_t)sid name:(NSString * _Nonnull)submissionName new:(NSInteger)new_ flag:(NSInteger)flag onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)cloneForm:(int64_t)formID onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)deleteFormQuestion:(int64_t)formID questionID:(int64_t)qid onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)createFormQuestion:(int64_t)formID question:(NSDictionary<NSString *, id> * _Nonnull)question onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)createFormQuestions:(int64_t)formID questions:(NSString * _Nonnull)questions onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)editFormQuestion:(int64_t)formID questionID:(int64_t)qid questionProperties:(NSDictionary<NSString *, id> * _Nonnull)properties onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)setFormProperties:(int64_t)formID formProperties:(NSDictionary<NSString *, id> * _Nonnull)properties onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)setMultipleFormProperties:(int64_t)formID formProperties:(NSString * _Nonnull)properties onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)createForm:(NSDictionary<NSString *, id> * _Nonnull)form onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)createForms:(NSDictionary<NSString *, id> * _Nonnull)form onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)deleteForm:(int64_t)formID onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getSystemPlan:(NSString * _Nonnull)planType onSuccess:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (void)getSystemTime:(void (^ _Nonnull)(id _Nonnull))successBlock onFailure:(void (^ _Nonnull)(NSError * _Nonnull))failureBlock;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end

SWIFT_MODULE_NAMESPACE_POP
#pragma clang diagnostic pop
