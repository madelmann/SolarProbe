
import System.Collections.List;


private object StringList extends List<string> implements ICollection
{
    public string =operator( string ) const
    {
        var result = "";
        foreach ( string item : this ) {
            if ( result ) result += ",";

            result += item;
        }

        return result;
    }
}

