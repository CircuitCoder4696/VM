module experimental.Transclusion;

public class Transclusion {
    public static struct transclude {
        public string remainder;
        public string[string] transcudedVals;
        public this(string main, string transcludeString) {
            import std;
            writeln("Hello world.  ");
        };
    };
};

public class t_Transcusion {
    public void test(string[] ArgV) {
        auto v_00= Transcusion.transclude("print 2 + 8;", "print $(X) + $(Y);");
    };
};
