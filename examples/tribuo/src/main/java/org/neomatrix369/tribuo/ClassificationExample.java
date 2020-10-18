package org.neomatrix369.tribuo;

import java.nio.file.Paths;
import org.tribuo.*;
import org.tribuo.evaluation.TrainTestSplitter;
import org.tribuo.data.csv.CSVLoader;
import org.tribuo.classification.*;
import org.tribuo.classification.evaluation.*;
import org.tribuo.classification.sgd.linear.LogisticRegressionTrainer;
import com.fasterxml.jackson.databind.*;
import com.oracle.labs.mlrg.olcut.provenance.ProvenanceUtil;
import com.oracle.labs.mlrg.olcut.config.json.*;

public class ClassificationExample 
{
    public void run() throws Exception
    {
        System.out.println("~~ Running Tribuo Machine Classification");
    	System.out.println("~~~ Loading the data");
		var labelFactory = new LabelFactory();
		var csvLoader = new CSVLoader<>(labelFactory);

		// Download the raw dataset using this command:
		//     wget https://archive.ics.uci.edu/ml/machine-learning-databases/iris/bezdekIris.data
		var irisHeaders = new String[]{"sepalLength", "sepalWidth", "petalLength", "petalWidth", "species"};
		var irisesSource = csvLoader.loadDataSource(Paths.get("datasets/bezdekIris.data"),"species",irisHeaders);
		var irisSplitter = new TrainTestSplitter<>(irisesSource,0.7,1L);

		System.out.println("~~~~~~ Splitting datasets");
		var trainingDataset = new MutableDataset<>(irisSplitter.getTrain());
		var testingDataset = new MutableDataset<>(irisSplitter.getTest());
		System.out.println(String.format("Training data size = %d, number of features = %d, number of classes = %d",trainingDataset.size(),trainingDataset.getFeatureMap().size(),trainingDataset.getOutputInfo().size()));
		System.out.println(String.format("Testing data size = %d, number of features = %d, number of classes = %d",testingDataset.size(),testingDataset.getFeatureMap().size(),testingDataset.getOutputInfo().size()));
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println("");

		System.out.println("~~~ Training the model ~~~");
		Trainer<Label> trainer = new LogisticRegressionTrainer();
		System.out.println(trainer.toString());		

		Model<Label> irisModel = trainer.train(trainingDataset);
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println("");

		System.out.println("~~~ Evaluating the model ~~~");
		var evaluator = new LabelEvaluator();
		var evaluation = evaluator.evaluate(irisModel,testingDataset);
		System.out.println(evaluation.toString());

		System.out.println(evaluation.getConfusionMatrix().toString());
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println("");

		System.out.println("~~~ Model Metadata ~~~");
		var featureMap = irisModel.getFeatureIDMap();
		for (var v : featureMap) {
    		System.out.println(v.toString());
    		System.out.println();
		}

		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println("");

		System.out.println("~~~ Model Provenance ~~~");
		var provenance = irisModel.getProvenance();
		System.out.println("~~~~~~ Datasets provenance");
		System.out.println(ProvenanceUtil.formattedProvenanceString(provenance.getDatasetProvenance().getSourceProvenance()));

		System.out.println("~~~~~~ Trainer provenance");
		System.out.println(ProvenanceUtil.formattedProvenanceString(provenance.getTrainerProvenance()));

		ObjectMapper objMapper = new ObjectMapper();
		objMapper.registerModule(new JsonProvenanceModule());
		objMapper = objMapper.enable(SerializationFeature.INDENT_OUTPUT);

		String jsonProvenance = objMapper.writeValueAsString(ProvenanceUtil.marshalProvenance(provenance));
		System.out.println("~~~~~~ Save provenance in JSON format");
		System.out.println(jsonProvenance);

		System.out.println("~~~~~~ Print model metadata as raw string");
		System.out.println(irisModel.toString());

		System.out.println("~~~~~~ Save evaluation provenance data as JSON");
		String jsonEvaluationProvenance = objMapper.writeValueAsString(ProvenanceUtil.convertToMap(evaluation.getProvenance()));
		System.out.println("~~~~~~ Print evaluation provenance data (JSON)");
		System.out.println(jsonEvaluationProvenance);
		System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		System.out.println("");
    }
}
