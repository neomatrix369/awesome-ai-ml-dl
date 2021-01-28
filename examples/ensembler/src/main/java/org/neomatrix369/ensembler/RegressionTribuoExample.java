package org.neomatrix369.ensembler;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Set;
import java.util.List;

import org.tribuo.*;
import org.tribuo.data.csv.CSVLoader;
import deepnetts.examples.util.CsvFile;
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
import org.tribuo.regression.Regressor;
import org.tribuo.Prediction;
import org.tribuo.util.Util;

public class RegressionTribuoExample
{
    private boolean showOutput;
    private static String csvTrainingFilename = "datasets/linear-for-tribuo.csv";
    private static String csvValidationFilename = "datasets/deepnetts-linear-regression-validation.csv";

    public RegressionTribuoExample(boolean showOutput) {
        this.showOutput = showOutput;
    }

    public void run() throws Exception
    {
        System.out.println("~~ Running Tribuo Machine Regression");
    	System.out.println("~~~ Loading the data");
		var regressionFactory = new RegressionFactory();
        var csvLoader = new CSVLoader<>(',',regressionFactory);
        var xValues = csvLoader.loadDataSource(Paths.get(csvTrainingFilename), "y");
        System.out.println("~~~~~~ Splitting datasets");
        var splitter = new TrainTestSplitter<>(xValues, 0.7f, 0L);
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

        var validationDataset = csvLoader.loadDataSource(Paths.get(csvValidationFilename), "y");

        var predictionsLrSGD = lrsgdModel.predict(validationDataset);
        savePredictions(validationDataset, predictionsLrSGD, "datasets/tribuo-linear-regression-sgd-validation.csv");
        var predictionsLrADA = lradaModel.predict(validationDataset);
        savePredictions(validationDataset, predictionsLrADA, "datasets/tribuo-linear-regression-ada-validation.csv");
        var predictionsCart = cartModel.predict(validationDataset);
        savePredictions(validationDataset, predictionsCart, "datasets/tribuo-linear-regression-cart-validation.csv");
        var predictionsXgbModel = xgbModel.predict(validationDataset);
        savePredictions(validationDataset, predictionsXgbModel, "datasets/tribuo-linear-regression-xgb-validation.csv");
    }

    public void savePredictions(ListDataSource validationDataset, 
                                List<Prediction<Regressor>> predictions, 
                                String targetCsvFilename) throws Exception {
        String responseNames = "x,y";
        var mutableValidationDataset = new MutableDataset<>(validationDataset);

        double[][] predictionValueAsDouble = new double[predictions.size()][2];
        int index = 0; 
        for (var example: mutableValidationDataset.getData()) {
            var result = example.toString();
            result = result.replace("[(", "").replace(")])", "");
            result = result.split("features=")[1].split(", ")[1];
            predictionValueAsDouble[index][0] = Double.parseDouble(result);
            index = index + 1;
        }

        index = 0; 
        for (Prediction<Regressor> prediction: predictions) {
            predictionValueAsDouble[index][1] = prediction.getOutput().getValues()[0];
            index = index + 1;
        }


        CsvFile.write(predictionValueAsDouble, targetCsvFilename, responseNames);
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
