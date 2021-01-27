/**
 *  DeepNetts is pure Java Deep Learning Library with support for Backpropagation
 *  based learning and image recognition.
 *
 *  Copyright (C) 2017  Zoran Sevarac <sevarac@gmail.com>
 *
 * This file is a modified copy of the examples section of DeepNetts by Zoran Sevarac.
 *
*/

package org.neomatrix369.deepnetts;

import deepnetts.examples.util.CsvFile;
import deepnetts.examples.util.Plot;
import deepnetts.data.DataSets;
import javax.visrec.ml.eval.EvaluationMetrics;
import deepnetts.eval.Evaluators;
import deepnetts.net.FeedForwardNetwork;
import deepnetts.net.layers.activation.ActivationType;
import deepnetts.net.loss.LossType;
import deepnetts.net.train.BackpropagationTrainer;
import deepnetts.util.Tensor;
import java.io.IOException;
import java.util.Arrays;
import javax.visrec.ml.data.DataSet;

public class RegressionExample
{
    protected static String csvFilename = "datasets/linear.csv";

    public void run() throws Exception
    {
        int inputsNum = 1;
        int outputsNum = 1;
        double test_train_ratio = 0.7;
        float some_input_value = 0.2f;
        
        System.out.println("~~ Running DeepNetts Machine Regression");
    	System.out.println("~~~ Loading the data");
        DataSet dataSet = DataSets.readCsv(csvFilename , inputsNum, outputsNum);

        System.out.println("~~~~~~ Splitting datasets");
        DataSet[] trainTestSet = DataSets.trainTestSplit(dataSet, test_train_ratio);

		System.out.println(String.format("Training data size = %d", trainTestSet[0].size()));
		System.out.println(String.format("Testing data size = %d", trainTestSet[1].size()));
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println("");

		System.out.println("~~~ Training the model ~~~");
        FeedForwardNetwork neuralNet = FeedForwardNetwork.builder()
                    .addInputLayer(inputsNum)
                    .addOutputLayer(outputsNum, ActivationType.LINEAR)
                    .lossFunction(LossType.MEAN_SQUARED_ERROR)
                    .build();

        BackpropagationTrainer trainer = neuralNet.getTrainer();
        trainer.setMaxError(0.0002f)
                .setMaxEpochs(10000)
                .setBatchMode(false)
                .setLearningRate(0.01f);

        // train network using loaded data set
        neuralNet.train(dataSet);
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println("");

		System.out.println("~~~ Evaluating the model ~~~");
        EvaluationMetrics pe = neuralNet.test(dataSet);
        System.out.println(pe);

        // print out learned model
        float slope = neuralNet.getLayers().get(1).getWeights().get(0);
        float intercept = neuralNet.getLayers().get(1).getBiases()[0];
        System.out.println("Original function: y = 0.5 * x + " + String.valueOf(some_input_value));
        System.out.println("Estimated/learned function: y = " + slope + " * x + "+intercept);

		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println("");

		// perform prediction for some input value
        float[] predictedOutput = neuralNet.predict(new float[] {some_input_value});
        System.out.println("Predicted output for " + String.valueOf(some_input_value) + " :" + Arrays.toString(predictedOutput));

        plotTrainingData();

        // plot predictions for some random data
        plotPredictions(neuralNet);
        
        EvaluationMetrics pm = Evaluators.evaluateRegressor(neuralNet, dataSet);
        System.out.println(pm);
    }

    public static void plotPredictions(FeedForwardNetwork nnet) {
        double[][] data = new double[100][2];

        for(int i=0; i<data.length; i++) {
            data[i][0] =  0.5-Math.random();
            nnet.setInput(new Tensor(1, 1, new float[] { (float)data[i][0] }));
            data[i][1] = nnet.getOutput()[0];
        }

        Plot.scatter(data, "Neural Network Predictions");
    }

    public static void plotTrainingData() throws IOException {
        double[][] dataPoints = CsvFile.read(csvFilename, 30);
        Plot.scatter(dataPoints, "Training data");
    }
}
