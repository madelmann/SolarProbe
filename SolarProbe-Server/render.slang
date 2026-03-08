#!/usr/bin/env slang

// Library imports
import FileReader.Scanner;
import libJson;
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

    RenderServices( config );
}

private void RenderServices( Config config )
{
    var bodyProbeTpl   = new String( new Scanner( DIRECTORY + "templates/xymon/body-probe.tpl" ).getText() );
    var bodyTpl        = new String( new Scanner( DIRECTORY + "templates/xymon/body.tpl" ).getText() );
    var headerProbeTpl = new String( new Scanner( DIRECTORY + "templates/xymon/header-probe.tpl" ).getText() );
    var headerTpl      = new String( new Scanner( DIRECTORY + "templates/xymon/header.tpl" ).getText() );
    var indexTpl       = new String( new Scanner( DIRECTORY + "templates/xymon/index.tpl" ).getText() );
    var systemTpl      = new String( new Scanner( DIRECTORY + "templates/xymon/system.tpl" ).getText() );

    string systemsStr;

    // foreach ( Pair<string, StringList> system : config.Systems ) {
    //     print( cast<string>( system ) );
    // }

    // foreach ( Pair<string, StringList> probes : config.Probes ) {
    //     print( cast<string>( probes ) );
    // }

    foreach ( Pair<string, StringList> probes : config.Probes ) {
        var tmpBodyTpl   = copy bodyTpl;
        var tmpHeaderTpl = copy headerTpl;
        var tmpSystemTpl = copy systemTpl;

        string probesBodyStr;
        string probesHeaderStr;

        var host = probes.first;

        foreach ( string probe : probes.second ) {
            var probeBodyTpl   = copy bodyProbeTpl;
            var probeHeaderTpl = copy headerProbeTpl;

            var reader = new JsonReader();
            var value = JsonObject reader.parse( new Scanner( streval( "{{{DIRECTORY}}}nodes/{{{host}}}/{{{probe}}}.status" ) ).getText() );

            probeBodyTpl.ReplaceAll( "{{{COLOR}}}", value[ "state" ].asString() + "-recent" );
            probeBodyTpl.ReplaceAll( "{{{HOST}}}",  host );
            probeBodyTpl.ReplaceAll( "{{{PROBE}}}", probe );

            probesBodyStr += cast<string>( probeBodyTpl );

            probeHeaderTpl.ReplaceAll( "{{{PROBE}}}", probe );

            probesHeaderStr += cast<string>( probeHeaderTpl );
        }

        tmpBodyTpl.ReplaceAll( "{{{HOST}}}", host );
        tmpBodyTpl.ReplaceAll( "{{{PROBES}}}", probesBodyStr );

        tmpHeaderTpl.ReplaceAll( "{{{PROBES}}}", probesHeaderStr );

        tmpSystemTpl.ReplaceAll( "{{{HEADER}}}", cast<string>( tmpHeaderTpl ) );
        tmpSystemTpl.ReplaceAll( "{{{NAME}}}", "System" );
        tmpSystemTpl.ReplaceAll( "{{{BODY}}}",   cast<string>( tmpBodyTpl ) );

        systemsStr += cast<string>( tmpSystemTpl );
    }

    indexTpl.ReplaceAll( "{{{COLOR}}}", "green" );
    indexTpl.ReplaceAll( "{{{DATE}}}", strftime( "%Y-%m-%dT%H:%M:%S" ) );
    indexTpl.ReplaceAll( "{{{SYSTEMS}}}", systemsStr );

    print( cast<string>( indexTpl ) );
}
