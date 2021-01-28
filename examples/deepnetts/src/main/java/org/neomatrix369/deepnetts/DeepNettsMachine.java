package org.neomatrix369.deepnetts;

import java.util.Arrays;
import org.neomatrix369.deepnetts.ClassificationExample.*;
import org.neomatrix369.deepnetts.RegressionExample.*;

public class DeepNettsMachine
{
    public static void main( String[] args ) throws Exception
    {
    	System.out.println("~ Running DeepNetts Machine");
    	System.out.println("CLI Params: " + Arrays.toString(args));
    	if ((args.length > 0) && (args[0].toLowerCase().contains("regression"))) {
             new RegressionExample().run();
    	} else {
            new ClassificationExample().run();
        }
    }
}
