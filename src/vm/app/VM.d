module app.VM;

public struct Proc {
  ulong r0,r1,r2,r3,cp,dp,fr,kr;
  public ubyte[] mem;
};

public class VM {
	public static bool run= true;
	public static bool allowFullIO= false;
	public static bool allowNativeExt= true;
	public static Proc proc= Proc();
	public static ulong limit= 400;
	public static void delegate()[256] xe,xe_ff;
	private void xe_00() {};
	private void xe_ff_00() {
    this.proc.mem += Proc();
  };
	static this() {
		this.xe[0x00]= &this.xe_00;
		this.xe[0xff]= &this.xe_ff;
		this.xe_ff[x00]= &this.xe_ff_00;
	};
	public this(ubyte[] mem) {
    this.proc.mem= mem;
  };
};
