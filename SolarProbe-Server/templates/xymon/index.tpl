<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html">
<META HTTP-EQUIV="REFRESH" CONTENT="60">
<META HTTP-EQUIV="EXPIRES" CONTENT="Sat, 01 Jan 2001 00:00:00 GMT">
<META HTTP-EQUIV="Set-Cookie" CONTENT="pagepath=servers; path=/">
<META HTTP-EQUIV="Set-Cookie" CONTENT="host=; path=/">
<TITLE>{{{COLOR}}} : SolarProbe - Status @ {{{DATE}}}</TITLE>

<!-- Styles for the Xymon body  -->
<link rel="stylesheet" type="text/css" href="gifs/xymonbody.css">

<!-- Styles for the menu bar -->
<link rel="stylesheet" type="text/css" href="/menu/xymonmenu-blue.css">

<!-- The favicon image -->
<link rel="shortcut icon" href="gifs/favicon-{{{COLOR}}}.ico">

</HEAD>

<BODY class="{{{COLOR}}}">

<TABLE SUMMARY="Topline" WIDTH="100%">
<TR>
  <TD VALIGN=MIDDLE ALIGN=LEFT WIDTH="30%">
    <FONT FACE="Arial, Helvetica" SIZE="+1" COLOR="silver"><B>SolarProbe</B></FONT>
  </TD>
  <TD VALIGN=MIDDLE ALIGN=CENTER WIDTH="40%">
    <CENTER><FONT FACE="Arial, Helvetica" SIZE="+1" COLOR="silver"><B>Current Status</B></FONT></CENTER>
  </TD>
  <TD VALIGN=MIDDLE ALIGN=RIGHT WIDTH="30%">
   <FONT FACE="Arial, Helvetica" SIZE="+1" COLOR="silver"><B>{{{DATE}}}</B></FONT>
  </TD>
</TR>
<TR>
  <TD COLSPAN=3> <HR WIDTH="100%"> </TD>
</TR>
</TABLE>
<BR>

<CENTER> 

<A NAME=begindata>&nbsp;</A>
<A NAME=hosts-blk>&nbsp;</A>

<A NAME="group-_font_size_1_Xymon_infrastructure_font"></A>

{{{SYSTEMS}}}
<BR>
<A NAME=hosts-blk-1>&nbsp;</A>

<TABLE SUMMARY="Bottomline" WIDTH="100%">
<TR>
  <TD> <HR WIDTH="100%"> </TD>
</TR>
<TR>
  <TD ALIGN=RIGHT><FONT FACE="Arial, Helvetica" SIZE="-2" COLOR="silver"><B><A HREF="http://xymon.sourceforge.net/" style="text-decoration: none">SolarProbe 0.1.0</A></B></FONT></TD>
</TR>
</TABLE>

<!-- Don't rely just on HTML to set the cookies -->
<!-- http://lists.xymon.com/pipermail/xymon/2018-June/045538.html -->
<script type="text/javascript">
    var metas = document.getElementsByTagName('meta');

    for (var i=0; i<metas.length; i++) {
        var type = metas[i].getAttribute("HTTP-EQUIV");
        if (type == "Set-Cookie") {
            var prop = metas[i].getAttribute("CONTENT");
            document.cookie = prop;
        }
    }
</script>



</BODY>
</HTML>
