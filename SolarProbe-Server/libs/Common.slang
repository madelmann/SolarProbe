
import System.Collections.Map;
import System.String;
import Types;


public object Config
{
    public Map<string, StringList> Probes;
    public StringList              ServerProbes;
    public Map<string, StringList> Systems;

    public void Constructor()
    {
        Probes       = new Map<string, StringList>();
        ServerProbes = new StringList();
        Systems      = new Map<string, StringList>();
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
        result += LINEBREAK;

        result += "ServerProbes: " + LINEBREAK;
        foreach ( string probe : ServerProbes ) {
            result += probe + LINEBREAK;
        }

        return result;
    }
}


public Config ParseConfig( string directory )
{
    var cfg = new Config();

    ParseProbeConfig( cfg, directory );
    ParseSystemConfig( cfg, directory );

    return cfg;
}

private void ParseProbeConfig( Config cfg, string directory )
{
    var config = new String( new Scanner( directory + "config/probes.conf" ).getText() );

    foreach ( string line : config.SplitBy( LINEBREAK ) ) {
        if ( !line ) {
            continue;
        }

        cfg.ServerProbes.push_back( line );
    }
}

private void ParseSystemConfig( Config cfg, string directory )
{
    var config = new String( new Scanner( directory + "config/systems.conf" ).getText() );

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
}
