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

    var config = ParseConfig( new String( new Scanner( DIRECTORY + "config/systems.conf" ).getText() ) );
    // print( cast<string>( config ) );

    ProcessNodes( config.Probes );
}

private void ProcessNodes( Map<string, StringList> nodes )
{
    foreach ( Pair<string, StringList> node : nodes ) {
        foreach ( string probe : node.second ) {
            var host = node.first;

            system( streval( "mkdir -p {{{DIRECTORY}}}/nodes/{{{host}}}" ) );
            system( streval( "{{{DIRECTORY}}}/extensions/{{{probe}}} {{{host}}} > {{{DIRECTORY}}}/nodes/{{{host}}}/{{{probe}}}.status" ) );
        }
    }
}



