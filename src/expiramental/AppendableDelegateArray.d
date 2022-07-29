module experimental.AppendableDelegateArray;

public class AppendableDelegateArray(D,T) {
    private D[] delegates;
    public void append(D delegatePtr) {
        this.delegates ~= (&delegatePtr)[0..1];
    };
    public T proc(T data) {
        foreach(d; this.delegates) {
            data= d(data);
        };
        return data;
    };
};

public class t_AppendableDelegateArray {
    AppendableDelegateArray ada= new AppendableDelegateArray!(int delegate(int), int);
    public void appendDelegates() {
        int m(int val) {
            return val * 3;
        };
        aha.append(&m);
        int b(int val) {
            return val + 2;
        };
        ada.append(&b);
    };
    public void testDelegateArray() {
        int v= 6;
        v= aha.proc(v);
        assert(v==20);
    };
    public void test(string[] ArgV) {
        this.appendDelegates();
        this.testDelegateArray();
    };
};
