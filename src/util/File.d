module util.File;

import std.file:append,read,write;
import util.Listener:FileListener;
import util.Path;

public class File {
    public FileListener[] localListeners= [];
    public Path fp;
    public this(Path filePath) {
        foreach(i, listener; FileListener.globalListeners) filePath= listener.preInit(filePath);
        foreach(i, listener; this.localListeners) filePath= listener.preInit(filePath);
        this.fp= filePath;
        foreach(i, listener; this.localListeners) filePath= listener.postInit(filePath);
        foreach(i, listener; FileListener.globalListeners) filePath= listener.postInit(filePath);
    };
    public void[] data() @property {
        void[] data= read(this.fp.fp);
        foreach(i, listener; this.localListeners) data= listener.onRead(data);
        foreach(i, listener; FileListener.globalListeners) data= listener.onRead(data);
        return data;
    };
    public void data(void[] data) @property {
        foreach(i, listener; FileListener.globalListeners) data= listener.onWrite(data);
        foreach(i, listener; this.localListeners) data= listener.onWrite(data);
        return write(this.fp.fp, data);
    };
    public T opBinary(string op)(T other) {
        static if(op=="+=") {
            foreach(i, listener; FileListener.globalListeners) other= listener.onAppend(other);
            foreach(i, listener; this.localListeners) other= listener.onAppend(other);
            append(fp.fp, other);
        }else static assert(0, "Operator "~op~" not implemented");
    };
};
