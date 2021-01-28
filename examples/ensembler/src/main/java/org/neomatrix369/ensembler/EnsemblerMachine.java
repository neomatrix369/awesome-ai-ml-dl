package org.neomatrix369.ensembler;

import java.util.Arrays;
import org.neomatrix369.ensembler.RegressionTribuoExample.*;
import org.neomatrix369.ensembler.RegressionDeepNettsExample.*;

public class EnsemblerMachine
{
    public static void main( String[] args ) throws Exception
    {
    	System.out.println("~ Running Ensembler Machine");
    	System.out.println("CLI Params: " + Arrays.toString(args));
    	boolean showOutput = true;
        new RegressionDeepNettsExample(showOutput).run();
        new RegressionTribuoExample(showOutput).run();        
    }
}
