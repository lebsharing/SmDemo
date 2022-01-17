# sm

A State Manager use example.
该项目使用Flutter 2.8.1

## Getting Started

该项目用于探索Flutter状态管理，使用目前所知的状态管理方法，去完善项目中的状态管理，
并且在不同方式下，项目结构的定义及规范。

一、Ephemeral State
    setState/ChangeNotifier/InheritedWidget/InheritedNotifier/InheritedModel/
    1、InheritedWidget
        InheritedWidget是一个向其子Widget共享数据的Widget.在InheritedWidget的子Widget中可以任意使用其共享的数据。
        使用方式（参考例子：sm/lib/module/base_eg/inherited_widget_eg.dart）
        （1）集成InheritedWidget实现子类，定义一个要共享的数据，重写updateShouldNotify(...)方法，该方法是处理什么
        时候通知子Widget刷新数据。
        class NameInheritedWidget extends InheritedWidget {
            final String name;
            const NameInheritedWidget({
                Key? key,
                required this.name,
                required Widget child,
            }) : super(key: key, child: child);
            //定义一个方法，方便在子树中获取共享数据
            static NameInheritedWidget? of(BuildContext context) {
                return context.dependOnInheritedWidgetOfExactType<NameInheritedWidget>();
            }
            //该回调决定当name发生变化的时候，是否通知子树依赖name的widget
            @override
            bool updateShouldNotify(covariant NameInheritedWidget oldWidget) {
                return oldWidget.name != name;
            }
        }
        （2）在InheritedWidget的子Widget中获取数据，
        //
        注意事项：
        （1）在子Widget中使用InheritedWidget定义好的of方法，传递的BuildContext必须是子Widget的BuildContext,
        否则不能正确获取要共享的数据
        //
        InheritedWidget的实现原理：
        查看Element中的源码：
        @override
        InheritedWidget dependOnInheritedElement(InheritedElement ancestor, { Object? aspect }) {
            assert(ancestor != null);
            _dependencies ??= HashSet<InheritedElement>();
            _dependencies!.add(ancestor);
            ancestor.updateDependencies(this, aspect);
            return ancestor.widget;
        }
        @override
        T? dependOnInheritedWidgetOfExactType<T extends InheritedWidget>({Object? aspect}) {
            assert(_debugCheckStateIsActiveForAncestorLookup());
            final InheritedElement? ancestor = _inheritedWidgets == null ? null : _inheritedWidgets![T];
            if (ancestor != null) {
                return dependOnInheritedElement(ancestor, aspect: aspect) as T;
            }
            _hadUnsatisfiedDependencies = true;
            return null;
        }
    2、ChangeNotifier
 
二、状态管理package
    Provider/ScopedModel/Redux/BloC/MobX/Get/
    1、Provider的使用
    
    2、BloC
    

三、参考链接
    how to choose between Redux's store and React's State;//https://github.com/reduxjs/redux/issues/1287#issuecomment-175351978


