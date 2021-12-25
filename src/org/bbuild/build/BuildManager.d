module org.bbuild.build.BuildManager;
import std.stdio:writeln;
import util.Path;

public class BuildManager {
    public Path fp;
    public this(Path fp) {
        this.fp= fp;
    };
    public static void main(string[] ArtV) {
        writeln("Hello world.  ");
    };
};

