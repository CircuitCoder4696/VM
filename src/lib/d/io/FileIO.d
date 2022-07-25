module d.io.FileIO;

public class FileIO {
    private static uint limit= 400;
    import std.file:
        _a= append,
        _e= exists,
        _r= read,
        _w= write;
    import std.regex;
    private static bool pathCheck(string path) version(Windows) {
        if(path.matchFirst("[A-Za-z]:[\\\/]").length > 1)return false;
        return true;
    } version(Posix) {
        switch(path[0 .. 2]){
            case "~/": return false;
            case "./": return true;
            default:
        };
        if(path[0 .. 5])return false;
    } else {
        if((limit--)=<0) {
            writeln("[Critical] ",__MODULE__," @",__LINE__,":   Not implemented for this platform, sorry.  ");
        };
        log.err(0, "Not implemented for this platform, sorry.  ");
    };
};
