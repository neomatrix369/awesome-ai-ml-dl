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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

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

public class MLPMnistSingleLayerRunner {

    @Parameter(names={"--action", "-a"})
    String action;

    @Parameter(names={"--output-dir", "-o"})
    String outputDir;

    @Parameter(names={"--input-dir", "-i"})
    String inputDir;

    private static final String MODEL_FILENAME = "mlpmnist-single-layer.pb";
    private static Logger log = LoggerFactory.getLogger(MLPMnistSingleLayerRunner.class);

    public static void main(String[] args) throws Exception {
        MLPMnistSingleLayerRunner mlpMnistRunner = new MLPMnistSingleLayerRunner();

        JCommander.newBuilder()
                .addObject(mlpMnistRunner)
                .build()
                .parse(args);

        mlpMnistRunner.execute();
    }

    private void execute() throws Exception {
        //number of rows and columns in the input pictures
        final int numRows = 28;
        final int numColumns = 28;

        final int outputClasses = 10; // number of output classes
        final int batchSize = 128; // batch size for each epoch
        final int rngSeed = 123; // random number seed for reproducibility
        final int numEpochs = 15; // number of epochs to perform
        final int trainingSet = 60000;
        final int testSet = 10000;
        double initialLearningRate = 1e-4;

        if ((action == null) || action.isEmpty()) {
            argumentMissingOrInvalidError("--action");
        }

        log.info(String.format("--action = %s", action));

        if (action.equalsIgnoreCase("train")) {
            if ((outputDir == null) || outputDir.isEmpty()) {
                argumentMissingOrInvalidError("--output-dir");
            }

            log.info(String.format("--output-dir = %s", outputDir));

            new MLPMnistSingleLayerTrain(MODEL_FILENAME, outputDir).execute(
                    numRows,
                    numColumns,
                    outputClasses,
                    batchSize,
                    rngSeed,
                    numEpochs,
                    trainingSet,
                    testSet,
                    initialLearningRate
            );
            return;
        }

        if (action.equalsIgnoreCase("evaluate")) {
            if ((inputDir == null) || inputDir.isEmpty()) {
                argumentMissingOrInvalidError("--input-dir");
            }

            log.info(String.format("--input-dir = %s", inputDir));

            new MLPMnistSingleLayerEvaluate(MODEL_FILENAME, inputDir)
                    .execute(batchSize, rngSeed);
        }
    }

    private void argumentMissingOrInvalidError(String argumentName) {
        log.warn(String.format("%s argument has not been passed in or no valid value has been provided", argumentName));
        showUsageText();
    }

    private void showUsageText() {
        log.info("Usage: ");
        log.info("   ./[command] --action train    --output-dir /path/to/output/dir");
        log.info("   or");
        log.info("   ./[command] --action evaluate --input-dir  /path/to/input/dir");
        System.exit(-1);
    }
}
