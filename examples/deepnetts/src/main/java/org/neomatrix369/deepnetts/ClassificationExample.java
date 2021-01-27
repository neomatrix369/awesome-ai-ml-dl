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

import deepnetts.data.DataSets;
import deepnetts.eval.ClassifierEvaluator;
import deepnetts.eval.ConfusionMatrix;
import javax.visrec.ml.eval.EvaluationMetrics;
import deepnetts.net.FeedForwardNetwork;
import deepnetts.net.layers.activation.ActivationType;
import deepnetts.net.loss.LossType;
import deepnetts.net.train.BackpropagationTrainer;
import deepnetts.net.train.opt.OptimizerType;
import deepnetts.util.DeepNettsException;
import java.io.IOException;
import javax.visrec.ml.data.DataSet;

public class ClassificationExample 
{
    public void run() throws Exception
    {
    	int numInputs = 4;  // corresponds to number of input features
        int numOutputs = 3; // corresponds to number of possible classes/categories
        double test_train_ratio = 0.6;

        System.out.println("~~ Running DeepNetts Machine Classification");
    	System.out.println("~~~ Loading the data");
		DataSet dataSet = DataSets.readCsv("datasets/iris_data_normalised.txt", numInputs, numOutputs, true);
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println("");

		System.out.println("~~~~~~ Splitting datasets");
		DataSet[] trainTestSet = dataSet.split(test_train_ratio, 1 - test_train_ratio);
        System.out.println(String.format("Training data size = %d", trainTestSet[0].size()));
        System.out.println(String.format("Testing data size = %d", trainTestSet[1].size()));
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println("");
		
		System.out.println("~~~ Training the model ~~~");
		// create instance of multi addLayer percetpron using builder
        FeedForwardNetwork neuralNet = FeedForwardNetwork.builder()
                .addInputLayer(numInputs)
                .addFullyConnectedLayer(5, ActivationType.TANH)
                .addOutputLayer(numOutputs, ActivationType.SOFTMAX)
                .lossFunction(LossType.CROSS_ENTROPY)
                .randomSeed(456)
                .build();
		System.out.println(neuralNet.toString());		

		BackpropagationTrainer trainer = neuralNet.getTrainer();
        trainer.setMaxError(0.04f);
        trainer.setLearningRate(0.01f);
        trainer.setMomentum(0.9f);
        trainer.setOptimizer(OptimizerType.MOMENTUM);

        neuralNet.train(trainTestSet[0]);
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println("");

		System.out.println("~~~ Evaluating the model ~~~");
		ClassifierEvaluator evaluator = new ClassifierEvaluator();
        EvaluationMetrics em = evaluator.evaluate(neuralNet, trainTestSet[1]);

		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println("");

		System.out.println("CLASSIFIER EVALUATION METRICS");
        System.out.println(em);
        System.out.println("CONFUSION MATRIX");
        ConfusionMatrix cm = evaluator.getConfusionMatrix();
        System.out.println(cm);

		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println("");
    }
}
