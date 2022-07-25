module d.io.FileIO;
import templates.DevToolChain;

public class FileIO {
    import std.stdio;
    private static uint limit= 400;
    import std.file:
        _a= append,
        _e= exists,
        _r= read,
        _w= write;
    import std.regex;
    private static bool pathCheck(string path) {
        version(Windows) {
            if(path.matchFirst("[A-Za-z]:[\\\\/]").length > 1)return false;
            return true;
        } version(Posix) {
            switch(path[0 .. 2]){
                case "~/": return false;
                case "./": return true;
                default:
            };
            if(path[0 .. 5])return false;
        } else {
            if((limit--) <= 0) {
                writeln("[Critical] ",__MODULE__," @",__LINE__,":   Not implemented for this platform, sorry.  ");
            };
            log.err(0, "Not implemented for this platform, sorry.  ");
        };
    };
    private string fp;
    public this(string filePath) {
        if(!pathCheck(filePath)){
            writeln("[Critical] ",__MODULE__," @",__LINE__,":   Non-local file-paths are restricted for file-io, permission has to be granted to it first!  ");
            return;
        };
        this.fp= filePath;
    };
    public void append(void[] data) {
        if(!_e(this.fp))return log.err(0, "Could not find file \"",this.fp,"\".  ");
        _a(this.fp, data);
    };
    public void[] read() {
        if(!_e(this.fp))return log.err(0, "Could not find file \"",this.fp,"\".  ");
        return _a(this.fp);
    };
    public void write(void[] data) {
        if(!_e(this.fp))return log.err(0, "Could not find file \"",this.fp,"\".  ");
        _w(this.fp, data);
    };
};
