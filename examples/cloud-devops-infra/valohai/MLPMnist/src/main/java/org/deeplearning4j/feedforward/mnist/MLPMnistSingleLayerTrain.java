package org.deeplearning4j.feedforward.mnist;

import org.deeplearning4j.datasets.iterator.impl.MnistDataSetIterator;
import org.deeplearning4j.nn.conf.MultiLayerConfiguration;
import org.deeplearning4j.nn.conf.NeuralNetConfiguration;
import org.deeplearning4j.nn.conf.layers.DenseLayer;
import org.deeplearning4j.nn.conf.layers.OutputLayer;
import org.deeplearning4j.nn.multilayer.MultiLayerNetwork;
import org.deeplearning4j.nn.weights.WeightInit;
import org.deeplearning4j.optimize.listeners.CheckpointListener;
import org.jetbrains.annotations.NotNull;
import org.nd4j.linalg.activations.Activation;
import org.nd4j.linalg.dataset.api.iterator.DataSetIterator;
import org.nd4j.linalg.learning.config.Nesterovs;
import org.nd4j.linalg.lossfunctions.LossFunctions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class MLPMnistSingleLayerTrain {

    private static Logger log = LoggerFactory.getLogger(MLPMnistSingleLayerTrain.class);

    private final String modelFileName;
    private final String targetDir;

    public MLPMnistSingleLayerTrain(String modelFilename, String targetDir) {
        this.modelFileName = modelFilename;
        this.targetDir = targetDir;
    }

    void execute(int numRows,
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

        DataSetIterator mnistTrainingSet = new MnistDataSetIterator(batchSize, true, rngSeed);

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
                .layer(new OutputLayer.Builder(LossFunctions.LossFunction.NEGATIVELOGLIKELIHOOD) //create hidden layer
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
                new ValohaiMetadataCreator(100),
                new CheckpointListener.Builder(targetDir)
                        .deleteExisting(true)
                        .saveEveryEpoch()
                        .build()
        );

        log.info("");
        log.info("Train model....");
        log.info("");
        log.info("Model summary");
        log.info(model.summary());
        model.fit(mnistTrainingSet, numEpochs);

        log.info("");
        log.info(String.format("Saving model %s", getModelFilename()));
        model.save(new File(getModelFilename()));

        log.info("");
        log.info(String.format("Finished training at %s", currentDateTimeAsString()));
    }

    @NotNull
    String currentDateTimeAsString() {
        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy hh:mm:ss.SSS");
        return LocalDateTime.now().format(dateTimeFormatter);
    }

    @NotNull
    String getModelFilename() {
        return Paths.get(targetDir, modelFileName).toString();
    }
}
