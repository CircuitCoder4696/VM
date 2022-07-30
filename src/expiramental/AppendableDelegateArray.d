module experimental.AppendableDelegateArray;

int example(int val) {
    auto xyz= new int[2];
    return val *(cast(int) xyz.length);
};

public class AppendableDelegateArray {
    private typeof(&example)[] delegates;
    public void append(typeof(&example) delegatePtr) {
        this.delegates ~= (&delegatePtr)[0..1];
    };
    public int proc(int data) {
        foreach(d; this.delegates) {
            data= d(data);
        };
        return data;
    };
};

public class t_AppendableDelegateArray {
    AppendableDelegateArray ada= new AppendableDelegateArray();
    public void appendDelegates() {
        int m(int val) {
            return val * 3;
        };
        ada.append(&m);
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
