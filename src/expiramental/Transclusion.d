module experimental.Transclusion;

public class Transclusion {
    public static struct transclude {
        public string remainder;
        public string[string] transcudedVals;
        public this(string main, string transcludeString) {
            string[string] transcusionVars;
            string[][2] transcusionStructure= genTranscusionStructure(transcludeString);
            string[] transcusionData= getTranscludedData(main, transcusionStructure);
            transclusionVars= combineTransclusionParts(transcusionVars, transcusionData);
            return transclusionVars;
        };
    };
};

public class t_Transcusion {
    public void test(string[] ArgV) {
        auto v_00= Transcusion.transclude("print 2 + 8;", "print $(X) + $(Y);");
    };
};
