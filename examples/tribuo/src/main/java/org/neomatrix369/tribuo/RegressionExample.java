package org.neomatrix369.tribuo;

import java.nio.file.Path;
import java.nio.file.Paths;

import org.tribuo.*;
import org.tribuo.data.csv.CSVLoader;
import org.tribuo.datasource.ListDataSource;
import org.tribuo.evaluation.TrainTestSplitter;
import org.tribuo.math.optimisers.*;
import org.tribuo.regression.*;
import org.tribuo.regression.evaluation.*;
import org.tribuo.regression.sgd.RegressionObjective;
import org.tribuo.regression.sgd.linear.LinearSGDTrainer;
import org.tribuo.regression.sgd.objectives.SquaredLoss;
import org.tribuo.regression.rtree.CARTRegressionTrainer;
import org.tribuo.regression.xgboost.XGBoostRegressionTrainer;
import org.tribuo.util.Util;

public class RegressionExample
{
    public void run() throws Exception
    {
        System.out.println("~~ Running Tribuo Machine Regression");
    	System.out.println("~~~ Loading the data");
		var regressionFactory = new RegressionFactory();
        var csvLoader = new CSVLoader<>(';',regressionFactory);

		// Download the raw dataset using this command:
		//    wget https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv
        var wineSource = csvLoader.loadDataSource(Paths.get("datasets/winequality-red.csv"),"quality");
        System.out.println("~~~~~~ Splitting datasets");
        var splitter = new TrainTestSplitter<>(wineSource, 0.7f, 0L);
        Dataset<Regressor> trainData = new MutableDataset<>(splitter.getTrain());
        Dataset<Regressor> evalData = new MutableDataset<>(splitter.getTest());

		System.out.println(String.format("Training data size = %d, number of features = %d, number of classes = %d",trainData.size(),trainData.getFeatureMap().size(),trainData.getOutputInfo().size()));
		System.out.println(String.format("Testing data size = %d, number of features = %d, number of classes = %d",evalData.size(),evalData.getFeatureMap().size(),evalData.getOutputInfo().size()));
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println("");

		System.out.println("~~~ Training the model ~~~");
        var lrsgd = new LinearSGDTrainer(
            new SquaredLoss(), // loss function
            SGD.getLinearDecaySGD(0.01), // gradient descent algorithm
            10,                // number of training epochs
            trainData.size()/4,// logging interval
            1,                 // minibatch size
            1L                 // RNG seed
        );
        var lrada = new LinearSGDTrainer(
            new SquaredLoss(),
            new AdaGrad(0.01),
            10,
            trainData.size()/4,
            1,
            1L
        );
        var cart = new CARTRegressionTrainer(6);
        var xgb = new XGBoostRegressionTrainer(50);
        var lrsgdModel = train("Linear Regression (SGD)",lrsgd,trainData);
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println("");

		System.out.println("~~~ Evaluating the model ~~~");
		evaluate(lrsgdModel,evalData);

		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println("");

		System.out.println("~~~ Improving over standard SGD with AdaGrad ~~~");
		var lradaModel = train("Linear Regression (AdaGrad)",lrada,trainData);
        evaluate(lradaModel,evalData);

		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println("");

		System.out.println("~~~ Trees and ensembles ~~~");
		var cartModel = train("CART",cart,trainData);
        evaluate(cartModel,evalData);

		var xgbModel = train("XGBoost",xgb,trainData);
        evaluate(xgbModel,evalData);
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println("");
    }

    public Model<Regressor> train(String name, Trainer<Regressor> trainer, Dataset<Regressor> trainData) {
        // Train the model
        var startTime = System.currentTimeMillis();
        Model<Regressor> model = trainer.train(trainData);
        var endTime = System.currentTimeMillis();
        System.out.println("Training " + name + " took " + Util.formatDuration(startTime,endTime));
        // Evaluate the model on the training data (this is a useful debugging tool)
        RegressionEvaluator eval = new RegressionEvaluator();
        var evaluation = eval.evaluate(model,trainData);
        // We create a dimension here to aid pulling out the appropriate statistics.
        // You can also produce the String directly by calling "evaluation.toString()"
        var dimension = new Regressor("DIM-0",Double.NaN);
        System.out.printf("Evaluation (train):%n  RMSE %f%n  MAE %f%n  R^2 %f%n",
                evaluation.rmse(dimension), evaluation.mae(dimension), evaluation.r2(dimension));
        return model;
    }

    public void evaluate(Model<Regressor> model, Dataset<Regressor> testData) {
        // Evaluate the model on the test data
        RegressionEvaluator eval = new RegressionEvaluator();
        var evaluation = eval.evaluate(model,testData);
        // We create a dimension here to aid pulling out the appropriate statistics.
        // You can also produce the String directly by calling "evaluation.toString()"
        var dimension = new Regressor("DIM-0",Double.NaN);
        System.out.printf("Evaluation (test):%n  RMSE %f%n  MAE %f%n  R^2 %f%n",
                evaluation.rmse(dimension), evaluation.mae(dimension), evaluation.r2(dimension));
    }
}
