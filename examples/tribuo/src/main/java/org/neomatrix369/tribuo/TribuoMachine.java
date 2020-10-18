package org.neomatrix369.tribuo;

import java.util.Arrays;
import org.neomatrix369.tribuo.ClassificationExample.*;
import org.neomatrix369.tribuo.RegressionExample.*;

public class TribuoMachine
{
    public static void main( String[] args ) throws Exception
    {
    	System.out.println("~ Running Tribuo Machine");
    	System.out.println("CLI Params: " + Arrays.toString(args));
    	if ((args.length > 0) && (args[0].toLowerCase().contains("regression"))) {
             new RegressionExample().run();
    	} else {
            new ClassificationExample().run();
        }
    }
}
