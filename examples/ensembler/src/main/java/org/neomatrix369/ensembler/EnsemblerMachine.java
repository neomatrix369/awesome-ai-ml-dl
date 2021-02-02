package org.neomatrix369.ensembler;

import java.util.Arrays;
import deepnetts.examples.util.CsvFile;
import org.neomatrix369.ensembler.RegressionTribuoExample.*;
import org.neomatrix369.ensembler.RegressionDeepNettsExample.*;

public class EnsemblerMachine
{
	private static String csvValidationFilename = "datasets/deepnetts-linear-regression-validation.csv";
	private static int UNSEEN_DATA_COUNT = 100;

    public static void main( String[] args ) throws Exception
    {
    	System.out.println("~ Running Ensembler Machine");
    	System.out.println("CLI Params: " + Arrays.toString(args));
    	
    	        // plot predictions for some random data
        double[][] data = new double[UNSEEN_DATA_COUNT][2];

        for(int i=0; i<UNSEEN_DATA_COUNT; i++) {
            data[i][0] = 0.5-Math.random();
            data[i][1] = 0;
        }

        CsvFile.write(data, csvValidationFilename, "x,y");

    	boolean showOutput = true;
        new RegressionDeepNettsExample(showOutput).run();
        new RegressionTribuoExample(showOutput).run();        
    }
}
