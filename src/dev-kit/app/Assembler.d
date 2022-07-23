module app.Assembler;

public class Assembler {
    public string fp;
    public string[] srcCode;
    public this(string filePath) {
        this.fp= filePath;
        this.src= (cast(string) read(filePath)).split("\n");
    };
};
