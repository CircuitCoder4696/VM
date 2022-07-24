module d.util.BinFile;

public class FileFormat {
    import d.proc.string;
    import d.util.bits;
    import std.conv:to;
    import std.stdio:writeln;
    private BinFile parent;
    public string objPath;
    public string[] symbols= [];
    public uint[string] symbolLines;
    public string[string] aliases;
    public string[][string] params;   //   List of parameters in each function.  
    public ulong[string] paramDefautValOffsets;   //   Offset of parameters on the stack, starting with 1 to make room for the return pointer.  
    public ulong[string] symbolDefautValOffsets;   //   Offset of symbols on the stack, starting just after the parameters.  
    private enum:uint {
        Executable,
        Loadable,
        Readable,
        Storable,
        Writable,
        Mode_IterLen,
    };
    private struct format_sectionHeader {
        BitField!Mode_IterLen mode;
    };
    import std.format;
    private struct format_mainHeader {
        uint magic;
        uint dts;
        ulong entry_Ptr;
        uint sectionTable_IterLen;
    };
    public size_t[] getMagic() {
        return [1,0];
    };
    public void[] genData() {   //   Generates the binary data of the file.  
        return [];   //   This returns an empty array by default.  
    };
    public size_t newSymbol(string symbol) {
        size_t result= this.symbols.length;
        this.symbols ~= [symbol];
        return result;
    };
    public size_t newSymbol(string symbol, uint offset) {
        size_t result= this.symbols.length;
        if(this.symbols.contains(symbol))this.symbols ~= [symbol];
        return result;
    };
    public size_t newParam(string param) {
        size_t result= this.params.length;
        this.params[param]= [];
        return result;
    };
    public this(BinFile parent) {
        this.parent= parent;
    };
};

public class bf_ByteCode:FileFormat {
    public this(BinFile parent) {
        super(parent);
    };
    public T getValue(T)(size_t ptr) {
        return (
            cast(T*) (
                (cast(size_t)this.data)
                +
                ptr
            )
        )[0];
    };
    public void __wMainHeader(format_mainHeader mainHeader, FileFormat fileFormat) {
        assert(fileFormat !is null, "`fileFormat` shouldn't be null.  ");
        writeln("::= ",fileFormat.symbols,";");
    };
    public void __wSectionHeaders(format_sectionHeader[] sectionHeaders, FileFormat fileFormat) {};
    override public void[] genData() {
        void[] result= new void[400];
        format_mainHeader mainHeader= *(cast(format_mainHeader*) result.ptr);
        // assert(this.ff !is null, "`bf_ByteCode:this(...).ff` shouldn't be null.  ");
        this.__wMainHeader(mainHeader, this);
        format_sectionHeader[] sectionHeaders= (cast(format_sectionHeader*) 
        (
            (cast(size_t)
                result.ptr
            )
            +
            format_mainHeader.sizeof
        ))[0..(
            mainHeader.sectionTable_IterLen
        )];
        this.__wSectionHeaders(sectionHeaders, this);
        return result;
    };
};

/++
binary_file provides `d.util->BinFile:this(string)` with data getters and setters, along with a builtin pointer for the getters and another for the setters.  You can choose not to let the pointer increment simply by passing -1 as the value of index.  
* `this.get08:ubyte(ptr:size_t,index:uint)`
* `this.get16:ushort(ptr:size_t,index:uint)`
* `this.get32:uint(ptr:size_t,index:uint)`
* `this.get64:ulong(ptr:size_t,index:uint)`

++/
public abstract class binary_file {
    public FileFormat ff;
    private string fs;
};

public class BinFile:binary_file {
    import std.stdio:writeln;
    public string start;
    public this(string filePath) {
        this.fs= filePath;
        this.ff= new bf_ByteCode(this);
    };
    public void newParam(string param) {
        this.ff.newParam(param);
    };
    public void newSymbol(string symbol) {
        this.ff.newSymbol(symbol);
    };
    public void newSymbol(string symbol, uint offset) {
        this.ff.newSymbol(symbol, offset);
    };
    public void newParam(string symbol, uint offset) {
        this.ff.newSymbol(symbol, offset);
    };
    public void[] data() @property {
        void[] result= this.ff.genData();
        return result;
    };
    public typeof(this) setObjPath(string path) {
        this.ff.objPath= path;
    };
    public string objPath() @property {
        return this.ff.objPath;
    }
};
