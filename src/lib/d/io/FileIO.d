module d.io.FileIO;
import templates.DevToolChain;

public class FileIO:DevToolChain {
    import std.stdio;
    private static uint limit= 4;
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
            import std.format;
            assert(0, "[Critical] %s @%s:   Not implemented for this platform, sorry.  ".format(__MODULE__, __LINE__));
        };
        assert(0);
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
        assert(limit--);
        if(!_e(this.fp))return log.error("Could not find file \"",this.fp,"\".  ");
        _a(this.fp, data);
    };
    public bool exists() @property {
        return _e(this.fp);
    };
    public void[] read() {
        if(!_e(this.fp)) {
            log.error("Could not find file \"",this.fp,"\".  ");
            return null;
        };
        return _r(this.fp);
    };
    public void write(void[] data) {
        if(!_e(this.fp)) {
            log.error(0, "Could not find file \"",this.fp,"\".  ");
            return;
        };
        _w(this.fp, data);
    };
};
