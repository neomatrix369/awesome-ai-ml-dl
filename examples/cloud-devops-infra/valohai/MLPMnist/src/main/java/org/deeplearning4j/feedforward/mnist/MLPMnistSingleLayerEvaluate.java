package org.deeplearning4j.feedforward.mnist;

import org.deeplearning4j.datasets.iterator.impl.MnistDataSetIterator;
import org.deeplearning4j.eval.Evaluation;
import org.deeplearning4j.nn.multilayer.MultiLayerNetwork;
import org.jetbrains.annotations.NotNull;
import org.nd4j.linalg.dataset.api.iterator.DataSetIterator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

public class MLPMnistSingleLayerEvaluate {

    private static Logger log = LoggerFactory.getLogger(MLPMnistSingleLayerEvaluate.class);
    private String modelFilename;
    private final String targetDir;

    public MLPMnistSingleLayerEvaluate(String modelFilename, String targetDir) {
        this.modelFilename = modelFilename;
        this.targetDir = targetDir;
    }

    void execute(int batchSize, int rngSeed) throws IOException {
        log.info("Evaluate model....");
        log.info(String.format("BatchSize: %d", batchSize));
        DataSetIterator mnistTestSet = new MnistDataSetIterator(batchSize, false, rngSeed);
        if (! new File(getModelFilename()).exists()) {
            log.error(String.format("Model file %s does not exists", getModelFilename()));
            log.error("Re-run with the correct path specified with --input-dir");
            log.error("Aborting...");
            System.exit(-1);
        }
        log.info(String.format("Loading saved model: %s", getModelFilename()));
        MultiLayerNetwork model = MultiLayerNetwork.load(new File(getModelFilename()), false);
        Evaluation eval = model.evaluate(mnistTestSet);
        log.info(eval.stats());
        log.info("Finished evaluating model....");
    }

    @NotNull
    String getModelFilename() {
        return Paths.get(targetDir, modelFilename).toString();
    }
}
