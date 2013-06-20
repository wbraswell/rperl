//using namespace std;  // needed for iostream (cout, cin, endl, ...), MAY CAUSE NAMESPACE COLLISSIONS?!?
using std::cout;  using std::endl;

class ObjectTMP {
public:
	ObjectTMP() {}
	~ObjectTMP() {}
/*
	virtual void foo() { cout << "in ObjectTMP->foo(), have this = '" << this << "'" << endl; }
	virtual void info() = 0;
	virtual bool isa(char *klass) = 0;
	virtual bool can(char *method) = 0;
*/
	void foo() { cout << "in ObjectTMP->foo(), have this = '" << this << "'" << endl; }
	void fly() { printf("in ObjectTMP->fly(), FLYIN'\n"); }
};

class PlaneTMP : public ObjectTMP {
public:
	PlaneTMP() {}
  ~PlaneTMP() {}

  /*
  virtual void info() { foo(); }
  virtual bool isa(char *klass) { return strcmp(klass, "ObjectTMP")==0; }
  virtual bool can(char *method) {
  */
  void info() { foo(); }
  bool isa(char *klass) { return strcmp(klass, "ObjectTMP")==0; }
  bool can(char *method) {
    bool yes = false;
    yes |= strcmp(method, "print")==0;
    yes |= strcmp(method, "info")==0;
    yes |= strcmp(method, "isa")==0;
    yes |= strcmp(method, "can")==0;
    yes |= strcmp(method, "fly")==0;
    return yes;
  }
};
