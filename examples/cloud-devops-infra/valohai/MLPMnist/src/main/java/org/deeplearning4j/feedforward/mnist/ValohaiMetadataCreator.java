package org.deeplearning4j.feedforward.mnist;

import org.deeplearning4j.nn.api.Model;
import org.deeplearning4j.optimize.api.BaseTrainingListener;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.Serializable;

/**
 * Score iteration listener. Reports the score (value of the loss function )of the network during training every
 * N iterations
 *
 * @author Adam Gibson
 */
public class ValohaiMetadataCreator extends BaseTrainingListener implements Serializable {
    private int printIterations = 10;

    private static Logger log = LoggerFactory.getLogger(ValohaiMetadataCreator.class);

    /**
     * @param printIterations    frequency with which to print scores (i.e., every printIterations parameter updates)
     */
    public ValohaiMetadataCreator(int printIterations) {
        this.printIterations = printIterations;
    }

    /** Default constructor printing every 10 iterations */
    public ValohaiMetadataCreator() {}

    @Override
    public void iterationDone(Model model, int iteration, int epoch) {
        if (printIterations <= 0)
            printIterations = 1;
        if (iteration % printIterations == 0) {
            double score = model.score();
            System.out.println(String.format(
                    "{\"epoch\": %d, \"iteration\": %d, \"score (loss function)\": %f}",
                    epoch,
                    iteration,
                    score)
            );
        }
    }

    @Override
    public String toString(){
        return String.format("ScoreIterationListener(%d)", printIterations);
    }
}
