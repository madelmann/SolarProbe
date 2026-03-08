
import System.Collections.List;
import System.Collections.Map;
import System.String;


private object StringList extends List<string> implements ICollection
{
    public string =operator( string ) const
    {
        var result = "";
        foreach ( string probe : this ) {
            if ( result ) result += ",";

            result += probe;
        }

        return result;
    }
}

private object Config
{
    public Map<string, StringList> Probes;
    public Map<string, StringList> Systems;

    public void Constructor()
    {
        Probes  = new Map<string, StringList>();
        Systems = new Map<string, StringList>();
    }

    public string =operator( string ) const
    {
        string result;

        result += "Systems: " + LINEBREAK;
        foreach ( Pair<string, StringList> system : Systems ) {
            result += cast<string>( system ) + LINEBREAK;
        }
        result += LINEBREAK;
    
        result += "Probes: " + LINEBREAK;
        foreach ( Pair<string, StringList> probes : Probes ) {
            result += cast<string>( probes ) + LINEBREAK;
        }

        return result;
    }
}


private Config ParseConfig( String config )
{
    var cfg = new Config();

    string currentSystem;
    var nodes = new StringList();

    foreach ( string line : config.SplitBy( LINEBREAK ) ) {
        if ( !line ) {
            continue;
        }

        var idx = 0;

        var char = substr( line, idx, 1 );
        idx++;

        if ( char == "o" ) {
            idx++;

            if ( !nodes.empty() ) {
                cfg.Systems.insert( currentSystem, nodes );

                nodes = new StringList();
            }

            currentSystem = substr( line, idx );
            continue;
        }
        else if ( char == "-" ) {
            idx++;

            var colon = strfind( line, ":", idx );
            var node  = substr( line, idx, colon - idx );

            nodes.push_back( node );

            var probes = new StringList();

            var probesStr = new String( substr( line, colon + 1 ) );

            foreach ( string probe : probesStr.SplitBy( "," ) ) {
                probes.push_back( probe );
            }

            cfg.Probes.insert( node, probes );
        }
    }

    if ( !nodes.empty() ) {
        cfg.Systems.insert( currentSystem, nodes );
    }

    return cfg;
}
