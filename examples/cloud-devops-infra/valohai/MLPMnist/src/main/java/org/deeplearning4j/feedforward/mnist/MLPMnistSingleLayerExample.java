/*******************************************************************************
 * Copyright (c) 2015-2019 Skymind, Inc.
 *
 * This program and the accompanying materials are made available under the
 * terms of the Apache License, Version 2.0 which is available at
 * https://www.apache.org/licenses/LICENSE-2.0.
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations
 * under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 ******************************************************************************/

package org.deeplearning4j.feedforward.mnist;

import com.beust.jcommander.JCommander;
import com.beust.jcommander.Parameter;
import org.deeplearning4j.datasets.iterator.impl.MnistDataSetIterator;
import org.deeplearning4j.eval.Evaluation;
import org.deeplearning4j.nn.conf.MultiLayerConfiguration;
import org.deeplearning4j.nn.conf.NeuralNetConfiguration;
import org.deeplearning4j.nn.conf.layers.DenseLayer;
import org.deeplearning4j.nn.conf.layers.OutputLayer;
import org.deeplearning4j.nn.multilayer.MultiLayerNetwork;
import org.deeplearning4j.nn.weights.WeightInit;
import org.deeplearning4j.optimize.listeners.*;
import org.jetbrains.annotations.NotNull;
import org.nd4j.linalg.activations.Activation;
import org.nd4j.linalg.dataset.api.iterator.DataSetIterator;
import org.nd4j.linalg.learning.config.Nesterovs;
import org.nd4j.linalg.lossfunctions.LossFunctions.LossFunction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;


/**A Simple Multi Layered Perceptron (MLP) applied to digit classification for
 * the MNIST Dataset (http://yann.lecun.com/exdb/mnist/).
 *
 * This file builds one input layer and one hidden layer.
 *
 * The input layer has input dimension of numRows*numColumns where these variables indicate the
 * number of vertical and horizontal pixels in the image. This layer uses a rectified linear unit
 * (relu) activation function. The weights for this layer are initialized by using Xavier initialization
 * (https://prateekvjoshi.com/2016/03/29/understanding-xavier-initialization-in-deep-neural-networks/)
 * to avoid having a steep learning curve. This layer will have 1000 output signals to the hidden layer.
 *
 * The hidden layer has input dimensions of 1000. These are fed from the input layer. The weights
 * for this layer is also initialized using Xavier initialization. The activation function for this
 * layer is a softmax, which normalizes all the 10 outputs such that the normalized sums
 * add up to 1. The highest of these normalized values is picked as the predicted class.
 *
 */

 /*
  * Original example taken from DL4J and changed to use other DL4J APIs
  * Credits to the original authors and Skymind - the maintainers of DL4J
  */

public class MLPMnistSingleLayerExample {
    @Parameter(names={"--action", "-a"})
    String action;

    @Parameter(names={"--output-dir", "-o"})
    String outputDir;

    @Parameter(names={"--input-dir", "-i"})
    String inputDir;

    private static final String MODEL_FILENAME = "mlpmnist-single-layer.pb";
    private static Logger log = LoggerFactory.getLogger(MLPMnistSingleLayerExample.class);

    private String targetDir;

    public static void main(String[] args) throws Exception {
        MLPMnistSingleLayerExample mlpMnistSingleLayerExample = new MLPMnistSingleLayerExample();

        JCommander.newBuilder()
                .addObject(mlpMnistSingleLayerExample)
                .build()
                .parse(args);

        mlpMnistSingleLayerExample.run();
    }

    private void run() throws Exception {
        //number of rows and columns in the input pictures
        final int numRows = 28;
        final int numColumns = 28;

        final int outputClasses = 10; // number of output classes
        final int batchSize = 128; // batch size for each epoch
        final int rngSeed = 123; // random number seed for reproducibility
        final int numEpochs = 15; // number of epochs to perform
        final int trainingSet = 60000;
        final int testSet = 10000;

        if ((action == null) || action.isEmpty()) {
            argumentMissingOrInvalidError("--action");
        }

        log.info(String.format("--action = %s", action));

        if (action.equalsIgnoreCase("train")) {
            if ((outputDir == null) || outputDir.isEmpty()) {
                argumentMissingOrInvalidError("--output-dir");
            }

            targetDir = outputDir;
            log.info(String.format("--output-dir = %s", targetDir));

            train(
                    numRows,
                    numColumns,
                    outputClasses,
                    batchSize,
                    rngSeed,
                    numEpochs,
                    trainingSet,
                    testSet, 1e-4
            );
            return;
        }

        if (action.equalsIgnoreCase("evaluate")) {
            if ((inputDir == null) || inputDir.isEmpty()) {
                argumentMissingOrInvalidError("--input-dir");
            }

            targetDir = inputDir;
            log.info(String.format("--input-dir = %s", targetDir));

            evaluate(batchSize, rngSeed);
        }
    }

    private void argumentMissingOrInvalidError(String argumentName) {
        log.warn(String.format("%s argument has not been passed in or no valid value has been provided", argumentName));
        showUsageText();
    }

    private void showUsageText() {
        log.info("Usage: ");
        log.info("   [jar command] --action train --output-dir /path/to/output/dir");
        log.info("   or");
        log.info("   [jar command] --action evaluate --input-dir /path/to/input/dir");
        System.exit(-1);
    }

    private void train(int numRows,
                       int numColumns,
                       int outputClasses,
                       int batchSize,
                       int rngSeed,
                       int numEpochs,
                       int trainingSet,
                       int testSet,
                       double initialLearningRate) throws IOException {
        log.info(String.format("Classes: %d", outputClasses));
        log.info(String.format("Epochs: %d", numEpochs));
        log.info(String.format("Batch Size: %d", batchSize));
        log.info(String.format("Training set: %d digits", trainingSet));
        log.info(String.format("Test set: %d digits", testSet));
        int iterationsPerEpoch = (int) Math.ceil(trainingSet / batchSize);
        log.info(String.format("Iterations per epoch: ~%d", iterationsPerEpoch));
        log.info(String.format("Total iterations at the end of last epoch: ~%d", iterationsPerEpoch * numEpochs));
        log.info(String.format("Initial Learning rate: %f", initialLearningRate));
        log.info("");
        log.info(String.format("Started training at %s", currentDateTimeAsString()));

        //Get the DataSetIterators:

        DataSetIterator mnistTrainSet = new MnistDataSetIterator(batchSize, true, rngSeed);

        log.info("Build model....");
        MultiLayerConfiguration conf = new NeuralNetConfiguration.Builder()
                .seed(rngSeed) //include a random seed for reproducibility
                // use stochastic gradient descent as an optimization algorithm
                .updater(new Nesterovs(0.006, 0.9))
                .l2(initialLearningRate)
                .list()
                .layer(new DenseLayer.Builder() //create the first, input layer with xavier initialization
                        .nIn(numRows * numColumns)
                        .nOut(1000)
                        .activation(Activation.RELU)
                        .weightInit(WeightInit.XAVIER)
                        .build())
                .layer(new OutputLayer.Builder(LossFunction.NEGATIVELOGLIKELIHOOD) //create hidden layer
                        .nIn(1000)
                        .nOut(outputClasses)
                        .activation(Activation.SOFTMAX)
                        .weightInit(WeightInit.XAVIER)
                        .build())
                .build();

        MultiLayerNetwork model = new MultiLayerNetwork(conf);
        model.init();
        //print the score with every 1 iteration
        model.setListeners(
                new ValohaiListener(100),
                new CheckpointListener.Builder(targetDir)
                        .deleteExisting(true)
                        .saveEveryEpoch()
                        .build()
        );

        log.info("Train model....");
        log.info("");
        log.info("Model summary");
        log.info(model.summary());
        model.fit(mnistTrainSet, numEpochs);

        log.info(String.format("Saving model %s", getModelFilename()));
        model.save(new File(getModelFilename()));
        log.info(String.format("\nFinished training at %s", currentDateTimeAsString()));
    }

    private void evaluate(int batchSize, int rngSeed) throws IOException {
        log.info("Evaluate model....");
        log.info(String.format("BatchSize: %d", batchSize));
        DataSetIterator mnistTestSet = new MnistDataSetIterator(batchSize, false, rngSeed);
        if (! new File(getModelFilename()).exists()) {
            log.error(String.format("Model file %s does not exists", getModelFilename()));
            log.error("Aborting...");
            System.exit(-1);
        }
        log.info(String.format("Loading saved model: %s", getModelFilename()));
        MultiLayerNetwork model = MultiLayerNetwork.load(new File(getModelFilename()), false);
        Evaluation eval = model.evaluate(mnistTestSet);
        log.info(eval.stats());
    }

    @NotNull
    private String getModelFilename() {
        return Paths.get(targetDir,  MODEL_FILENAME).toString();
    }

    @NotNull
    private String currentDateTimeAsString() {
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy hh:mm:ss.SSS");
        return LocalDateTime.now().format(dateTimeFormatter);
    }
}
