#!/usr/bin/env slang

// Library imports
import FileReader.Scanner;
import libParam;

// Project imports
import libs.Common;


private string DIRECTORY;

public void Main( int argc, string args )
{
    var params = new ParameterHandler( argc, args, false );

    DIRECTORY = params.directoryName();

    var config = ParseConfig( DIRECTORY );
    // print( cast<string>( config ) );

    ProcessNodes( config );
}

private void ProcessNodes( Config config )
{
    foreach ( Pair<string, StringList> node : config.Probes ) {
        foreach ( string probe : node.second ) {
            if ( !config.ServerProbes.contains( probe ) ) {
                continue;
            }

            var host = node.first;

            system( streval( "mkdir -p {{{DIRECTORY}}}/nodes/{{{host}}}" ) );
            system( streval( "{{{DIRECTORY}}}/extensions/{{{probe}}} {{{host}}} > {{{DIRECTORY}}}/nodes/{{{host}}}/{{{probe}}}.status" ) );
        }
    }
}

