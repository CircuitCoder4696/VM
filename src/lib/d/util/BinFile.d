module d.util.BinFile;

public class FileFormat {
    import d.util.bits;
    import std.conv:to;
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
    pragma(msg, "format_sectionHeader.sizeof= %s;".format(format_sectionHeader.sizeof));
    private struct format_mainHeader {
        uint magic;
        uint dts;
        ulong entry_Ptr;
        uint sectionTable_IterLen;
    };
    public size_t[] getMagic() {
        return [1,0];
    };
    public ulong getEntry_Pointer() {
        return (cast(format_mainHeader*) this.data)[0];
    };
};

public class bf_ByteCode:FileFormat {
    private void[] data;
    public this(void[] data) {
        this.data= data;
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
};

public abstract class binary_file {
    public FileFormat ff;
    private string fs;
    // private void[] data;
    private ubyte get08(size_t ptr, uint index= 0) {
        return (cast(ubyte*) ((cast(size_t)this.ff.data) + ptr))[index];
    };
    private ushort get16(size_t ptr, uint index= 0) {
        return (cast(ushort*) ((cast(size_t)this.ff.data) + ptr))[index];
    };
    private uint get32(size_t ptr, uint index= 0) {
        return (cast(uint*) ((cast(size_t)this.ff.data) + ptr))[index];
    };
    private ulong get64(size_t ptr, uint index= 0) {
        return (cast(ulong*) ((cast(size_t)this.ff.data) + ptr))[index];
    };
    private void set08(size_t ptr, uint index= 0, ubyte val= 0) {
        (cast(ubyte*) ((cast(size_t)this.ff.data) + ptr))[index]= val;
    };
    private void set16(size_t ptr, uint index= 0, ushort val= 0) {
        (cast(ushort*) ((cast(size_t)this.ff.data) + ptr))[index]= val;
    };
    private void set32(size_t ptr, uint index= 0, uint val= 0) {
        (cast(uint*) ((cast(size_t)this.ff.data) + ptr))[index]= val;
    };
    private void set64(size_t ptr, uint index= 0, ulong val= 0) {
        (cast(ulong*) ((cast(size_t)this.ff.data) + ptr))[index]= val;
    };
    public size_t wPtr= 0;
    public size_t rPte= 0;
    public ubyte get08(int index) {
        if(index==-1)return this.get08(this.rPtr, 0);
        ubyte v= this.get08(this.rPtr, index);
        this.rPtr += typeof(v).sizeof;
        return v;
    };
    public ushort get16(int index) {
        if(index==-1)return this.get16(this.rPtr, 0);
        ushort v= this.get16(this.rPtr, index);
        this.rPtr += typeof(v).sizeof;
        return v;
    };
    public uint get32(int index) {
        if(index==-1)return this.get32(this.rPtr, 0);
        uint v= this.get32(this.rPtr, index);
        this.rPtr += typeof(v).sizeof;
        return v;
    };
    public ulong get64(int index) {
        if(index==-1)return this.get64(this.rPtr, 0);
        ulong v= this.get64(this.rPtr, index);
        this.rPtr += typeof(v).sizeof;
        return v;
    };
};

public class BinFile(FileFormat):binary_file {
    public string start;
    public this(string filePath) {
        this.fs= filePath;
        this.ff= new FileFormat(new void[60000]);
    };
};