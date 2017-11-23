#include <memory>
#include <iostream>

class MyClass {
public:
    // data members
    int bar = 12;
    int bax = 13;

    // accessors & mutators
    // NEED UPGRADE EXISTING RPERL CODE GEN: no need for "this->" in accessors & mutators
    int get_bar() { return bar; }
    int set_bar(int bar_new) { bar = bar_new; }
    int get_bax() { return bax; }
    int set_bax(int bax_new) { bax = bax_new; }
};

// [[[ OO SUBCLASSES ]]]
typedef std::unique_ptr<MyClass> MyClass_ptr;

// wrapper class
class NEW_MyClass {
public:
    // wrapped object
    MyClass_ptr wrapped_object;

    // constructor w/ initializer list for wrapped_object data member
    NEW_MyClass() : wrapped_object{new MyClass()} {}

    // initializers
    NEW_MyClass& bar(int bar_init) { wrapped_object->bar = bar_init; return *this; }
    NEW_MyClass& bax(int bax_init) { wrapped_object->bax = bax_init; return *this; }

    // move semantics
    MyClass_ptr&& NEW() { return std::move(wrapped_object); }
};

int main() {
    MyClass_ptr my_object_default1(new MyClass);

    std::cout << "in main(), have my_object_default1->bar = " << my_object_default1->bar << std::endl;
    std::cout << "in main(), have my_object_default1->bax = " << my_object_default1->bax << std::endl;

    std::cout << "in main(), have my_object_default1->get_bar() = " << my_object_default1->get_bar() << std::endl;
    std::cout << "in main(), have my_object_default1->get_bax() = " << my_object_default1->get_bax() << std::endl;

    MyClass_ptr my_object_default2 = NEW_MyClass{}.NEW();

    std::cout << "in main(), have my_object_default2->bar = " << my_object_default2->bar << std::endl;
    std::cout << "in main(), have my_object_default2->bax = " << my_object_default2->bax << std::endl;

    std::cout << "in main(), have my_object_default2->get_bar() = " << my_object_default2->get_bar() << std::endl;
    std::cout << "in main(), have my_object_default2->get_bax() = " << my_object_default2->get_bax() << std::endl;

    MyClass_ptr my_object_init = NEW_MyClass{}.bar(22).bax(33).NEW();

    std::cout << "in main(), have my_object_init->bar = " << my_object_init->bar << std::endl;
    std::cout << "in main(), have my_object_init->bax = " << my_object_init->bax << std::endl;

    std::cout << "in main(), have my_object_init->get_bar() = " << my_object_init->get_bar() << std::endl;
    std::cout << "in main(), have my_object_init->get_bax() = " << my_object_init->get_bax() << std::endl;

    return my_object_init->bar;
}
