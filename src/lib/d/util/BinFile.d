module d.util.BinFile;

public abstract class BinFile(FileFormat) {
    FileFormat ff;
    private string fs;
    private void[] data;
    private ubyte get08(size_t ptr, uint index= 0) {
        return (cast(ubyte*) ((cast(size_t)this.data) + ptr))[index];
    };
    private ushort get16(size_t ptr, uint index= 0) {
        return (cast(ushort*) ((cast(size_t)this.data) + ptr))[index];
    };
    private uint get32(size_t ptr, uint index= 0) {
        return (cast(uint*) ((cast(size_t)this.data) + ptr))[index];
    };
    private ulong get64(size_t ptr, uint index= 0) {
        return (cast(ulong*) ((cast(size_t)this.data) + ptr))[index];
    };
    private void set08(size_t ptr, uint index= 0, ubyte val= 0) {
        (cast(ubyte*) ((cast(size_t)this.data) + ptr))[index]= val;
    };
    private void set16(size_t ptr, uint index= 0, ushort val= 0) {
        (cast(ushort*) ((cast(size_t)this.data) + ptr))[index]= val;
    };
    private void set32(size_t ptr, uint index= 0, uint val= 0) {
        (cast(uint*) ((cast(size_t)this.data) + ptr))[index]= val;
    };
    private void set64(size_t ptr, uint index= 0, ulong val= 0) {
        (cast(ulong*) ((cast(size_t)this.data) + ptr))[index]= val;
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
    public this(string filePath) {
        this.fs= filePath;
    };
};
